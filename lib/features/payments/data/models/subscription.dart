import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';

class Subscription {
  final UserData userData;
  final String? hash;
  final SubscriptionType type;
  final List<String> paymentsNumbers;
  final bool haveNewPayments;

  Subscription({
    required this.userData,
    this.hash,
    required this.paymentsNumbers,
    required this.type,
    this.haveNewPayments = false,
  });

  Subscription copyWith({
    List<String>? paymentsNumbers,
    bool? haveNewPayments,
  }) {
    return Subscription(
      userData: this.userData,
      paymentsNumbers: paymentsNumbers ?? this.paymentsNumbers,
      hash: this.hash,
      type: this.type,
      haveNewPayments: haveNewPayments ?? this.haveNewPayments,
    );
  }

  String typeToString() {
    switch (this.type) {
      case SubscriptionType.taxes:
        return 'taxes';
      case SubscriptionType.trials:
        return 'trials';
      case SubscriptionType.fsspTrials:
        return 'fsspTrials';
      default:
        return 'fines';
    }
  }

  static SubscriptionType typeFromString(String type) {
    switch (type) {
      case 'taxes':
        return SubscriptionType.taxes;
      case 'trials':
        return SubscriptionType.trials;
      case 'fsspTrials':
        return SubscriptionType.fsspTrials;
      default:
        return SubscriptionType.fines;
    }
  }
}

enum SubscriptionType {
  taxes,
  trials,
  fines,
  fsspTrials,
}
