import 'package:baza_gibdd_gai/features/credit_rating/data/models/orders_response.dart';

class UserReport {
  final String fullName;
  final String region;
  final String status;
  final DateTime reportDate;
  final String birthDate;
  final String inn;
  final List<DownloadLink> downloadLinks;
  final String passport;
  final String issueDate;
  final String departmentCode;

  UserReport({
    required this.fullName,
    required this.region,
    required this.status,
    required this.reportDate,
    required this.birthDate,
    required this.inn,
    required this.passport,
    required this.issueDate,
    required this.departmentCode,
    required this.downloadLinks,
  });

  factory UserReport.fromJson(Map<String, dynamic> json) {
    return UserReport(
      fullName: json['fullName'] ?? '',
      region: json['region'] ?? '',
      status: json['status'] ?? '',
      reportDate: DateTime.parse(json['reportDate']),
      birthDate: json['birthDate'] ?? '',
      inn: json['inn'] ?? '',
      passport: json['passport'] ?? '',
      issueDate: json['issueDate'] ?? '',
      departmentCode: json['departmentCode'] ?? '',
      downloadLinks: json['downloadLinks'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'region': region,
      'status': status,
      'reportDate': reportDate.toIso8601String(),
      'birthDate': birthDate,
      'inn': inn,
      'passport': passport,
      'issueDate': issueDate,
      'departmentCode': departmentCode,
    };
  }
}
