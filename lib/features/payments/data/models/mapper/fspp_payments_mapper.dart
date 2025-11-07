import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_fssp_trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fssp_trial.dart';

class FsppPaymentsMapper {
  static FsspTrial fromApi(ApiFsspTrial searchResponse) {
    return FsspTrial(
      debtor: searchResponse.debtor,
      ip: searchResponse.ip,
      requisites: searchResponse.requisites,
      amountOwed: searchResponse.amountOwed,
      department: searchResponse.department,
      bailiff: searchResponse.bailiff,
      region: searchResponse.region,
      ipend: searchResponse.ipend,
      isExternalPayment: searchResponse.isExternalPayment,
      paymentUrl: searchResponse.paymentUrl,
    );
  }
}
