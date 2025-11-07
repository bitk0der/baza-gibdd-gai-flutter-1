
class FsspTrial {
  String? debtor;
  String ip;
  String? requisites;
  String? amountOwed;
  String? department;
  String? bailiff;
  String? region;
  String? ipend;
  String paymentUrl;
  bool isExternalPayment;

  FsspTrial({
    required this.debtor,
    required this.ip,
    required this.requisites,
    required this.amountOwed,
    required this.department,
    required this.bailiff,
    required this.region,
    required this.ipend,
    required this.paymentUrl,
    required this.isExternalPayment,
  });
}