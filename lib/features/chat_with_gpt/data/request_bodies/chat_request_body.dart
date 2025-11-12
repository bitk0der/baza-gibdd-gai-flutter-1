import 'dart:io';

import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';

typedef JsonMap = Map<String, dynamic>;

class ChatRequestBody {
  static JsonMap sendMessageBody(String message, [String? userId]) {
    if (userId != null) {
      return {'message': message, 'userId': userId};
    }
    return {'message': message};
  }

  static JsonMap getLastMessageBody(String? userId, String? dialogId) {
    return {
      "userId": userId,
      "dialogId": dialogId,
      'bundle': packageInfo.packageName,
      'platform': Platform.isAndroid ? 'android' : 'ios',
      "version": '${packageInfo.version}+${packageInfo.buildNumber}',
    };
  }

  static JsonMap getLastMessageBodyNotification(String? userId) {
    return {
      "userId": userId,
      "isNotification": true,
      'bundle': packageInfo.packageName,
      'platform': Platform.isAndroid ? 'android' : 'ios',
      "version": '${packageInfo.version}+${packageInfo.buildNumber}',
    };
  }
}
