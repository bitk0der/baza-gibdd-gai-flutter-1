class ResponseMessageModel {
  final String messageId;
  final String message;
  final String? title;
  final List<ButtonModel> buttons;
  final bool isUserMessage;
  final int time;

  ResponseMessageModel({
    required this.messageId,
    required this.message,
    required this.isUserMessage,
    required this.time,
    this.title,
    required this.buttons,
  });

  // Фабричный метод для создания экземпляра из JSON
  factory ResponseMessageModel.fromJson(Map<String, dynamic> json) {
    var buttons = json['buttons'] != null ? json['buttons'] as List : [];
    List<ButtonModel> buttonsList = buttons
        .map((msg) => ButtonModel.fromJson(msg))
        .toList();
    return ResponseMessageModel(
      messageId: json['messageId'],
      message: json['message'],
      buttons: buttonsList,
      title: json['title'],
      isUserMessage: json['isUserMessage'] ?? false,
      time: json['time'] ?? DateTime.now().toUtc().millisecondsSinceEpoch,
    );
  }

  // Метод для преобразования экземпляра в JSON
  Map<String, dynamic> toJson() {
    return {
      'messageId': messageId,
      'message': message,
      'isUserMessage': isUserMessage,
      'time': time,
      'buttons': List.generate(
        buttons.length,
        (index) => buttons[index].toJson(),
      ),
    };
  }

  factory ResponseMessageModel.getEmpty() {
    return ResponseMessageModel(
      isUserMessage: false,
      messageId: '',
      message: '',
      buttons: [],
      time: DateTime.now().millisecondsSinceEpoch,
    );
  }
}

class ButtonModel {
  final String text;
  final String link;
  final String type;

  ButtonModel({required this.text, required this.link, required this.type});

  factory ButtonModel.fromJson(Map<String, dynamic> json) {
    return ButtonModel(
      text: json['text'],
      link: json['link'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'text': text, 'link': link, 'type': type};
  }
}

class MessagesResponse {
  final List<ResponseMessageModel> messages;
  final String? error;
  final String? status;
  final String? checkDate;

  MessagesResponse({
    required this.messages,
    required this.error,
    required this.status,
    required this.checkDate,
  });

  // Фабричный метод для создания экземпляра из JSON
  factory MessagesResponse.fromJson(Map<String, dynamic> json) {
    var messageList = json['messages'] != null ? json['messages'] as List : [];

    List<ResponseMessageModel> messagesList = messageList
        .map((msg) => ResponseMessageModel.fromJson(msg))
        .toList();

    return MessagesResponse(
      messages: messagesList,
      error: json['error'],
      status: json['status'],
      checkDate: json['checkDate'],
    );
  }
  MessagesResponse copyWith({
    List<ResponseMessageModel>? messages,
    String? error,
    String? status,
    String? checkDate,
  }) {
    return MessagesResponse(
      messages: messages ?? this.messages,
      error: error ?? this.error,
      status: status ?? this.status,
      checkDate: checkDate ?? this.checkDate,
    );
  }

  // Метод для преобразования экземпляра в JSON
  Map<String, dynamic> toJson() {
    return {
      'messages': messages.map((msg) => msg.toJson()).toList(),
      'checkDate': checkDate,
    };
  }
}
