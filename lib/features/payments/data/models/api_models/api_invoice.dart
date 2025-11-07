import 'api_to_pay_element.dart';

class ApiInvoice {
  static const _idKey = 'invoiceId';
  static const _dateTimeKey = 'date';
  static const _deleteFromHistoryKey = 'deleteFromHistory';
  static const _statusKey = 'status';
  static const _statusTextKey = 'statusText';
  static const _paymentUrlKey = 'paymentUrl';
  static const _totalToPayKey = 'totalToPay';
  static const _totalCommissionKey = 'totalCommissionRub';
  static const _paymentReceiptUrlKey = 'paymentReceiptUrl';
  static const _isPaymentReceiptIframeKey = 'isPaymentReceiptIframe';

  final String id;
  final int dateTime;
  final bool deleteFromHistory;
  final String status;
  final String statusText;
  final String paymentUrl;
  final double totalToPay;
  final double totalCommission;
  final List<ApiToPayElement> toPayElements;
  final String paymentReceiptUrl;
  final bool isPaymentReceiptIframe;

  ApiInvoice.fromMap(Map<String,dynamic> map, List<ApiToPayElement> toPayElements):
    id = map[_idKey].toString(),
    dateTime = map[_dateTimeKey],
    deleteFromHistory = map[_deleteFromHistoryKey],
    status = map[_statusKey],
    statusText = map[_statusTextKey],
    paymentUrl = map[_paymentUrlKey],
    totalToPay = map[_totalToPayKey] +.0,
    totalCommission = map[_totalCommissionKey] +.0,
    toPayElements = toPayElements,
    paymentReceiptUrl = map.containsKey(_paymentReceiptUrlKey) ? map[_paymentReceiptUrlKey] : null,
    isPaymentReceiptIframe = map.containsKey(_isPaymentReceiptIframeKey) ? map[_isPaymentReceiptIframeKey] : false;
}