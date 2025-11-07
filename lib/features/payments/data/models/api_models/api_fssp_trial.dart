class ApiFsspTrial {
  static const _nameKey = "name";
  static const _exeproductionKey = "exeproduction";
  static const _detailsKey = "details";
  static const _subjectKey = "subject";
  static const _departmentKey = "department";
  static const _bailiffKey = "bailiff";
  static const _regionKey = "region";
  static const _ipendKey = "ipend";
  static const _paymentUrlKey = 'paymentUrl';
  static const _isExternalPaymentKey = 'isExternalPayment';
  static const _valueKey = "value";

  final String? debtor;
  final String ip;
  final String? requisites;
  final String? amountOwed;
  final String? department;
  final String? bailiff;
  final String? region;
  final String? ipend;
  final String paymentUrl;
  final bool isExternalPayment;

  ApiFsspTrial.fromMap(Map<String, dynamic> map)
      : debtor = map.containsKey(_nameKey) ? map[_nameKey][_valueKey] : null,
        ip = map.containsKey(_exeproductionKey) ? map[_exeproductionKey][_valueKey] : '',
        requisites = map.containsKey(_detailsKey) ? map[_detailsKey][_valueKey] : null,
        amountOwed = map.containsKey(_subjectKey) ? map[_subjectKey][_valueKey] : null,
        department = map.containsKey(_departmentKey) ? map[_departmentKey][_valueKey] : null,
        bailiff = map.containsKey(_bailiffKey) ? map[_bailiffKey][_valueKey] : null,
        region = map.containsKey(_regionKey) ? map[_regionKey][_valueKey] : null,
        ipend = map.containsKey(_ipendKey) ? map[_ipendKey][_valueKey] : null,
        paymentUrl = map.containsKey(_paymentUrlKey) ? map[_paymentUrlKey] : "",
        isExternalPayment =
            map.containsKey(_isExternalPaymentKey) ? map[_isExternalPaymentKey] : false;
}
