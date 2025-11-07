class PaymentStatus {
  final bool success;
  final bool isPayed;

  PaymentStatus({required this.success, required this.isPayed});

  factory PaymentStatus.fromJson(Map<String, dynamic> json) {
    return PaymentStatus(
      success: json['success'] ?? false,
      isPayed: json['isPayed'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'isPayed': isPayed,
    };
  }
}
