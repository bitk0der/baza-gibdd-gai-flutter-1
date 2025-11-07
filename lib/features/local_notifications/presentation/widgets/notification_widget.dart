import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/bloc/notification_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

class NotificationWidget extends StatelessWidget {
  final MessagesResponse messageResponse;
  final bool isExtendedNotiification;
  const NotificationWidget({
    super.key,
    required this.messageResponse,
    this.isExtendedNotiification = false,
  });

  @override
  Widget build(BuildContext context) {
    Color orange = const Color(0xffFF331F);
    return AppCardLayout(
      isNeedShadow:
          !isExtendedNotiification && messageResponse.checkDate == null,
      padding: const EdgeInsets.all(15),
      /*   color: messageResponse.checkDate != null ? const Color(0xffE7E7E7) : null, */
      border: !isExtendedNotiification && messageResponse.checkDate == null
          ? Border.all(color: orange)
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (!isExtendedNotiification)
                AppCardLayout(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 9,
                  ),
                  color: messageResponse.checkDate != null
                      ? const Color(0xffB1B1B1)
                      : orange,
                  child: Text(
                    messageResponse.checkDate != null ? 'Просмотрено' : 'Новое',
                    style: TextStyles.h4.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              Text(
                messageResponse.checkDate != null
                    ? messageResponse.checkDate!
                    : DateFormat('dd.MM.yyyy, HH:mm').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          messageResponse.messages.first.time,
                        ),
                      ),
                style: TextStyles.h4.copyWith(
                  color: Colors.black.withValues(alpha: 0.4),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            messageResponse.messages.first.buttons.first.text,
            style: TextStyle(
              fontSize: 18.sp,
              height: 1.2,
              fontWeight: FontWeight.w600,
              color: Colors.black.withValues(alpha: 0.7),
            ),
          ),
          if (messageResponse.messages.first.message.isNotEmpty) ...[
            const SizedBox(height: 10),
            !isExtendedNotiification
                ? Text(
                    messageResponse.messages.first.message,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 15.sp,
                      height: 1.2,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  )
                : HtmlWidget(
                    messageResponse.messages.first.message,
                    textStyle: TextStyle(
                      fontSize: 15.sp,
                      height: 1.2,
                      color: Colors.black.withValues(alpha: 0.7),
                    ),
                  ),
          ],
          if (messageResponse.messages.first.buttons.isNotEmpty) ...[
            const SizedBox(height: 16),
            if (!isExtendedNotiification)
              GestureDetector(
                onTap: () {
                  GetIt.I<LocalNotificationBloc>().add(
                    RemoveNotificationFromCache(messageResponse),
                  );
                  GetIt.I<LocalNotificationBloc>().add(
                    SaveNotificationToCache(
                      messageResponse.copyWith(
                        checkDate: DateFormat(
                          'dd.MM.yyyy, HH:mm',
                        ).format(DateTime.now()),
                      ),
                    ),
                  );
                  if (!isExtendedNotiification) {
                    context.router.navigate(
                      NotificationDetailsRoute(
                        messageResponse: messageResponse,
                      ),
                    );
                    return;
                  }
                  tapHandler(context);
                },
                child: Text(
                  'Подробнее',
                  style: TextStyle(
                    fontSize: 16.sp,
                    height: 1.2,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xff0022FF),
                  ),
                ),
              ),
            if (isExtendedNotiification)
              AppButton(onTap: () => tapHandler(context), title: 'Получить'),
          ],
        ],
      ),
    );
  }

  tapHandler(BuildContext context) {
    if (!messageResponse.messages.first.buttons.first.link.startsWith('/')) {
      if (messageResponse.messages.first.buttons.first.type != 'external') {
        launchUrl(
          Uri.parse(messageResponse.messages.first.buttons.first.link),
          mode: LaunchMode.externalApplication,
        );
      } else {
        context.router.navigate(
          AppWebViewPage(
            title: messageResponse.messages.first.buttons.first.text,
            url: messageResponse.messages.first.buttons.first.link,
          ),
        );
      }
    } else {
      context.router.navigateNamed(
        messageResponse.messages.first.buttons.first.link,
      );
    }
  }
}
