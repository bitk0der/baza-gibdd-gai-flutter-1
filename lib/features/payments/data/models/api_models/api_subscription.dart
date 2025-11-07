
class ApiSubscription{
  static const _hashKey = "hash";
  static const _paymentsNumbersKey = "paymentsNumbers";
  static const _requestKey = "request";
  static const _typeKey = 'type';
  static const _haveNewPaymentsKey = 'haveNewPayments';


  final String? hash;
  final List paymentsNumbers;
  final List request;
  final String type;
  final bool haveNewPayments;

  ApiSubscription({
    this.hash,
    required this.paymentsNumbers,
    required this.request,
    required this.type,
    required this.haveNewPayments,
  });

  ApiSubscription.fromMap(Map<String, dynamic> map) :
    hash =  map[_hashKey],
    paymentsNumbers = map[_paymentsNumbersKey] ?? [],
    request = map[_requestKey],
    type = map[_typeKey],
    haveNewPayments = map[_haveNewPaymentsKey] ?? false;


  Map<String, dynamic> toMap() {
    return {
      _paymentsNumbersKey: paymentsNumbers,
      _requestKey: request,
      _typeKey: type,
      _haveNewPaymentsKey: haveNewPayments,
    };
  }
}