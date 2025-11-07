typedef JsonMap = Map<String, dynamic>;

class ChatRequestBody {
  static JsonMap getLastMessageBodyNotification(String? userId) {
    return {"userId": userId, "isNotification": true};
  }
}
