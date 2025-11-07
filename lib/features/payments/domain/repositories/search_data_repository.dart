import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fssp_trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/api_util.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/search_repository.dart';

@Injectable(as: SearchRepository)
class PaymentsSearchDataRepository extends SearchRepository {
  final ApiUtil _apiUtil;

  PaymentsSearchDataRepository(this._apiUtil);

  @override
  Future<Map<String, dynamic>> search(
      UserData userData, SubscriptionType subscriptionType) {
    return _apiUtil.searchDebt(userData, subscriptionType);
  }

  @override
  Future<List<Invoice>> getInvoiceInfo({required List<String> invoiceId}) {
    return _apiUtil.getInvoiceInfo(invoiceId);
  }

  @override
  Future<List<FsspTrial>> searchFssp(UserData userData) {
    return _apiUtil.searchFsspDebt(userData);
  }
}
