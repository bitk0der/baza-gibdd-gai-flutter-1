import 'package:baza_gibdd_gai/features/payments/data/models/body/timestamp.dart';

class GetInvoiceInfoBody {
  static const _invoiceIdKey = "invoiceid";
  static const _timestampKey = "timestamp";

  static Map<String, dynamic> getBody(List<String> invoiceId) {
    List<int> invoices = [];
    for (var element in invoiceId) {
      invoices.add(int.parse(element));
    }
    Map<String, dynamic> body = {
      _invoiceIdKey: invoices,
    };
    final timestamp = Timestamp.generate(body, 'Jkdus7');
    body.addAll({_timestampKey: timestamp});
    return body;
  }
}
