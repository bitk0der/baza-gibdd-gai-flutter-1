import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';

getDetails(String id, String channel, MessagesResponse messagesResponse) {
  var android = AndroidNotificationDetails(
    id,
    channel,
    importance: Importance.defaultImportance,
    priority: Priority.defaultPriority,
    showWhen: false,
    styleInformation: BigTextStyleInformation(
      messagesResponse.messages.last.message,
      htmlFormatBigText: true,
      htmlFormatTitle: true,
      htmlFormatContent: true,
      htmlFormatContentTitle: true,
      htmlFormatSummaryText: true,
    ),
  );
  // const iOS = IOSNotificationDetails();
  return NotificationDetails(android: android);
}

String getPatentMessage(String patentNumber, String type) {
  return '$type с номером $patentNumber не найден в базе данных МВД России. Истек срок действия документа или указаны некорректные данные.';
}

String getDepartMessage() {
  return 'Обнаружены основания, препятствующих въезду на территорию РФ, по линии МВД России';
}

String getFaceMessage() {
  return 'Обнаружен в реестре контролируемых лиц';
}

MessagesResponse getMessageResponse(String message, String path, String title) {
  return MessagesResponse(
    checkDate: null,
    messages: [
      ResponseMessageModel(
        buttons: [ButtonModel(text: title, link: path, type: 'type')],
        isUserMessage: false,
        message: message,
        messageId: '',
        time: DateTime.now().millisecondsSinceEpoch,
      ),
    ],
    error: null,
    status: 'done',
  );
}
