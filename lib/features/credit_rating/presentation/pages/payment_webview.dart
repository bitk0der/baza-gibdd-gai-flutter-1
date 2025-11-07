import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_web_view.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/payment_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/blocs/credit_rating_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class PaymentWebviewPage extends StatefulWidget {
  final Cart cart;
  const PaymentWebviewPage({super.key, required this.cart});

  @override
  State<PaymentWebviewPage> createState() => _PaymentWebviewPageState();
}

class _PaymentWebviewPageState extends State<PaymentWebviewPage> {
  CreditRatingCubit creditRatingCubit = GetIt.I<CreditRatingCubit>();

  @override
  void initState() {
    creditRatingCubit.changeStatus(false);
    creditRatingCubit.checkPayment(widget.cart.orderId, widget.cart.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: creditRatingCubit,
      listener: (c, state) {
        if (state is CreditRatingPaymentReadyState) {
          context.router.popUntilRoot();
        }
        if (state is CreditRatingErrorState) {
          if (context.router.currentPath == '/credit_rating/payment_webview') {
            var snackBar = SnackBar(
              content: Text(state.text ?? 'Произошла ошибка'),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        }
      },
      builder: (c, state) => AppWebView(
        onFinished: () => creditRatingCubit.changeStatus(true),
        title: widget.cart.items.first.title,
        url: widget.cart.paymentUrl,
      ),
    );
  }
}
