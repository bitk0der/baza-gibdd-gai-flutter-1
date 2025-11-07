import 'package:baza_gibdd_gai/features/payments/data/models/invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/payments/fssp_trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';

abstract class SearchRepository {
  Future<Map<String, dynamic>> search(
      UserData userData, SubscriptionType subscriptionType);
  Future<List<FsspTrial>> searchFssp(UserData userData);
  Future<List<Invoice>> getInvoiceInfo({required List<String> invoiceId});
}
