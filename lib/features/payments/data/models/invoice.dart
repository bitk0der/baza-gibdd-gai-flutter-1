import 'package:baza_gibdd_gai/features/payments/data/models/to_pay_element.dart';

class Invoice {
  final String id;
  final DateTime dateTime;
  final bool deleteFromHistory;
  final bool isDone;
  final String statusText;
  final String? paymentUrl;
  final double totalToPay;
  final double totalCommission;
  final List<ToPayElement> toPayElements;
  final String? paymentReceiptUrl;
  final bool isPaymentReceiptIframe;

  Invoice({
    required this.id,
    required this.dateTime,
    required this.deleteFromHistory,
    required this.isDone,
    required this.statusText,
    this.paymentUrl,
    required this.totalToPay,
    required this.totalCommission,
    required this.toPayElements,
    this.paymentReceiptUrl,
    required this.isPaymentReceiptIframe,
  });
}
