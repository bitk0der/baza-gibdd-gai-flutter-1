import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/mapper/to_pay_element_mapper.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/to_pay_element.dart';

class InvoiceMapper {
  static Invoice fromApi(ApiInvoice api) {
    bool isDone = false;
    if (api.status == 'done') isDone = true;
    List<ToPayElement> toPayElements = [];
    api.toPayElements.forEach((element) {
      toPayElements.add(ToPayElementMapper.fromApi(element));
    });

    return Invoice(
      id: api.id,
      dateTime: DateTime.fromMillisecondsSinceEpoch(api.dateTime),
      deleteFromHistory: api.deleteFromHistory,
      isDone: isDone,
      statusText: api.statusText,
      paymentUrl: api.paymentUrl,
      totalToPay: api.totalToPay,
      totalCommission: api.totalCommission,
      toPayElements: toPayElements,
      isPaymentReceiptIframe: api.isPaymentReceiptIframe,
      paymentReceiptUrl: api.paymentReceiptUrl,
    );
  }
}
