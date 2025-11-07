import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/blocs/subscription_bloc.dart';

class NotificationsCounter extends StatefulWidget {
  final double width;
  final double height;
  final double fontSize;
  final Color color;
  const NotificationsCounter({
    super.key,
    this.width = 14,
    this.height = 14,
    this.fontSize = 8,
    this.color = ColorStyles.invoiceStatusRed,
  });

  @override
  _NotificationsCounterState createState() => _NotificationsCounterState();
}

class _NotificationsCounterState extends State<NotificationsCounter> {
  late SubscriptionBloc _bloc;

  @override
  void initState() {
    _bloc = GetIt.I<SubscriptionBloc>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
        bloc: _bloc,
        builder: (_, state) {
          if (state is SubscriptionBlocReadyState) {
            final notCheckedNotifications = state.subscriptions.where(
              (subscription) => subscription.haveNewPayments,
            );
            if (notCheckedNotifications.isNotEmpty) {
              return Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: widget.color,
                ),
                child: Center(
                  child: Text(
                    '${notCheckedNotifications.length}',
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          }
          if (state is SubscriptionBlocShowButtonState) {
            final notCheckedNotifications = state.subscriptions.where(
              (subscription) => subscription.haveNewPayments,
            );
            if (notCheckedNotifications.isNotEmpty) {
              return Container(
                width: widget.width,
                height: widget.height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: widget.color,
                ),
                child: Center(
                  child: Text(
                    '${notCheckedNotifications.length}',
                    style: TextStyle(
                      fontSize: widget.fontSize,
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            } else {
              return const SizedBox();
            }
          } else {
            return const SizedBox();
          }
        });
  }
}
