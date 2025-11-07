import 'package:baza_gibdd_gai/features/payments/data/models/point.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';

abstract class StorageRepository {
  Future<void> savePoints(List<Point> points);
  Future<List<Point>> loadPoints();
  Future<void> savePaymentHistory({
    required List<String> history,
  });
  Future<List<String>> loadPaymentHistory();

  Future<void> saveSubscriptions({
    required List<Subscription> subscriptions,
  });
  Future<List<Subscription>> loadSubscriptions();

  Future<bool> isShowSubscriptionDialog();

  Future<bool> setShowSubscriptionDialog(bool value);
}
