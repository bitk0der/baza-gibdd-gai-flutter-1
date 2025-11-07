import 'dart:convert';
import 'package:auto_route/auto_route.dart';
import 'package:logger/logger.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/main.dart';
import 'package:url_launcher/url_launcher.dart';

void handleNotificationTap(String? payload) async {
  if (payload == null || payload.isEmpty) return;

  try {
    final response = MessagesResponse.fromJson(jsonDecode(payload));

    if (response.messages.isNotEmpty) {
      final message = response.messages.last;

      if (message.buttons.isNotEmpty) {
        final button = message.buttons.last;

        if (button.link.isNotEmpty) {
          if (button.type == 'external') {
            launchUrl(
              Uri.parse(button.link),
              mode: LaunchMode.externalApplication,
            );
          } else {
            push(AppWebViewPage(url: button.link, title: button.text));
          }
        }
      }
    }
  } catch (e) {
    Logger().e('Ошибка при обработке payload: $e');
  }
}

push(PageRouteInfo route) => appNavigatorKey.currentContext?.pushRoute(route);
