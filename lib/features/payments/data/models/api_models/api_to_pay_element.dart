class ApiToPayElement{
  static const _purposeKey = 'purpose';
  static const _amountKey = 'amountToPay';
  static const _commissionKey = 'commissionAmountRub';

  final String purpose;
  final double amount;
  final double commission;

  ApiToPayElement.fromMap(Map<String, dynamic> map) :
    purpose = map[_purposeKey],
    amount = map[_amountKey] + .0,
    commission = map[_commissionKey] + .0;
}