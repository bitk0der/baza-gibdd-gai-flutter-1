import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/utils/strings.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/invoice.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/invoice_search_bloc.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/payment_history_bloc.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/pages/payment_history_screen/widgets/invoice_card.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/custom_dialog.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/error_body.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/loading_screen.dart';

@RoutePage()
class PaymentHistoryScreen extends StatefulWidget {
  const PaymentHistoryScreen({super.key});

  @override
  State<PaymentHistoryScreen> createState() => _PaymentHistoryScreenState();
}

class _PaymentHistoryScreenState extends State<PaymentHistoryScreen> {
  late InvoiceSearchBloc _searchBloc;
  late PaymentHistoryBloc _historyBloc;

  @override
  void initState() {
    _historyBloc = GetIt.I<PaymentHistoryBloc>();
    _searchBloc = GetIt.I<InvoiceSearchBloc>();
    if (_historyBloc.invoicesIdList.isNotEmpty) {
      _searchBloc
          .add(InvoiceSearchBlocSearchEvent(_historyBloc.invoicesIdList));
    }
    super.initState();
  }

  @override
  void dispose() {
    _searchBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: CustomAppBar.getAppBar(
            title: Strings.paymentHistoryScreenTitle,
            onTapBackButton: () => context.maybePop(),
          ),
          body: SafeArea(
            child: _getBodyBuilder(),
          ),
        ),
      ),
    );
  }

  Widget _getBodyBuilder() {
    return _historyBloc.invoicesIdList.isEmpty
        ? const ErrorBody(text: Strings.emptyPaymentHistoryErrorLabel)
        : BlocBuilder(
            bloc: _searchBloc,
            builder: (context, state) {
              Widget child = const LoadingSearchIndicator();
              if (state is InvoiceSearchBlocReadyState) {
                if (state.invoices.isEmpty) {
                  child = const ErrorBody(
                      text: Strings.emptyPaymentHistoryErrorLabel);
                } else {
                  child = _getBody(state.invoices);
                }
              } else if (state is InvoiceSearchBlocErrorState) {
                child = const ErrorBody(text: Strings.searchScreenErrorLabel);
              }
              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: child,
              );
            },
          );
  }

  Widget _getBody(List<Invoice> invoices) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10.h),
        Expanded(
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.only(top: 10.h, bottom: 30.h),
            itemBuilder: (context, index) => InvoiceCard(
              invoice: invoices[index],
              onDelete: () {
                CustomDialog.show(
                  context: context,
                  title: 'Подтверждение на удаление',
                  subtitle: 'Вы действительно хотите удалить?',
                  buttonOneTitle: 'Отмена',
                  buttonTwoTitle: 'Удалить',
                  buttonTwoOnTap: () {
                    _historyBloc
                        .add(PaymentHistoryBlocDeleteEvent(invoices[index].id));
                  },
                );
              },
            ),
            separatorBuilder: (context, index) => SizedBox(height: 20.h),
            itemCount: invoices.length,
          ),
        ),
      ],
    );
  }
}
