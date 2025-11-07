class HcsModel {
  final int hcsTypeIndex;
  final String? year;
  final String? month;
  final String elsOrIpdNumber;
  final String lastName;
  final String firstName;
  final String? patronymic;

  HcsModel({
    required this.hcsTypeIndex,
    required this.year,
    required this.month,
    required this.elsOrIpdNumber,
    required this.lastName,
    required this.firstName,
    this.patronymic,
  });

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'year': year,
      'month': month,
      'elsOrIpdNumber': elsOrIpdNumber,
      'lastName': lastName,
      'firstName': firstName,
      'patronymic': patronymic,
    };
  }

  // Метод для создания объекта из JSON (если нужно)
  factory HcsModel.fromJson(Map<String, dynamic> json) {
    return HcsModel(
      hcsTypeIndex: json['hcsTypeIndex'],
      year: json['year'],
      month: json['month'],
      elsOrIpdNumber: json['elsOrIpdNumber'],
      lastName: json['lastName'],
      firstName: json['firstName'],
      patronymic: json['patronymic'],
    );
  }
}
