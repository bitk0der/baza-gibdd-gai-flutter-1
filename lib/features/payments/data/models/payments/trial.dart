import 'package:baza_gibdd_gai/features/payments/data/models/payments/payment.dart';

class Trial extends Payment {
  final String? name;
  final String? number;
  final String? organization;
  final double? summ;
  final DateTime? date;

  Trial({
    this.name,
    this.number,
    this.organization,
    this.summ,
    this.date,
  });

  factory Trial.fromJson(Map<String, dynamic> json) {
    return Trial(
      name: json['name'],
      number: json['id']['value'],
      organization: json['additionalInfo'][0]['value'],
      summ: json['amountTotal'] != null
          ? double.tryParse(json['amountTotal']['value'].toString()) ?? 0.0
          : null,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
    );
  }
}
