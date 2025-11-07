import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/bloc/notification_bloc.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/widgets/notification_widget.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

@RoutePage()
class NotificationDetailsPage extends StatefulWidget {
  final MessagesResponse messageResponse;
  const NotificationDetailsPage({super.key, required this.messageResponse});

  @override
  State<NotificationDetailsPage> createState() =>
      _NotificationDetailsPageState();
}

class _NotificationDetailsPageState extends State<NotificationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.fillColor,
      appBar: CustomAppBar.getAppBar(
        title: widget.messageResponse.messages.first.buttons.first.text,
        onTapBackButton: () => context.maybePop(),
        actions: [
          AppCircleButton(
            onTap: () {
              GetIt.I<LocalNotificationBloc>().add(
                RemoveNotificationFromCache(widget.messageResponse),
              );
              context.maybePop();
            },
            icon: Assets.icons.navBarIcons.chatNavBarIcon,
            backgroundColor: Colors.white24,
            iconColor: Colors.white,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(
          horizontal: 16,
          vertical: 23,
        ),
        child: Column(
          children: [
            NotificationWidget(
              messageResponse: widget.messageResponse,
              isExtendedNotiification: true,
            ),
          ],
        ),
      ),
    );
  }
}
