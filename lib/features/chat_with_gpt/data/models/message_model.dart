class UserDialogResponse {
  final UserDialog? userDialog;
  final String? error;

  UserDialogResponse({required this.userDialog, required this.error});

  // Фабричный метод для создания экземпляра из JSON
  factory UserDialogResponse.fromJson(Map<String, dynamic> json) {
    return UserDialogResponse(
        userDialog: json['userId'] != null ? UserDialog.fromJson(json) : null,
        error: json['error']);
  }

  // Метод для преобразования экземпляра в JSON
  Map<String, dynamic> toJson() {
    return {'userDialog': userDialog, 'diaerrorlogId': error};
  }
}

class UserDialog {
  final String userId;
  final String dialogId;
  final String operatorName;

  UserDialog({
    required this.userId,
    required this.dialogId,
    required this.operatorName,
  });

  // Фабричный метод для создания экземпляра из JSON
  factory UserDialog.fromJson(Map<String, dynamic> json) {
    return UserDialog(
      userId: json['userId'],
      dialogId: json['dialogId'],
      operatorName: json['operatorName'],
    );
  }

  // Метод для преобразования экземпляра в JSON
  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'dialogId': dialogId,
      'operatorName': operatorName,
    };
  }
}
