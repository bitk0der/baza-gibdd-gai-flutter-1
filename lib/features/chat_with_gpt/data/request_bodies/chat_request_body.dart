typedef JsonMap = Map<String, dynamic>;

class ChatRequestBody {
  static JsonMap sendMessageBody(String message, [String? userId]) {
    if (userId != null) {
      return {'message': message, 'userId': userId};
    }
    return {'message': message};
  }

  static JsonMap getLastMessageBody(String? userId, String? dialogId) {
    return {"userId": userId, "dialogId": dialogId};
  }

  static JsonMap getLastMessageBodyNotification(String? userId) {
    return {"userId": userId, "isNotification": true};
  }
}
