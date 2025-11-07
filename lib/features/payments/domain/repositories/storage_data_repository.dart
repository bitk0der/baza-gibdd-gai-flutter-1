import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/core/utils/sp_util.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/point.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/repositories/storage_repository.dart';
import 'package:baza_gibdd_gai/features/payments/domain/repositories/storage_util.dart';

@Injectable(as: StorageRepository)
class StorageDataRepository extends StorageRepository {
  final StorageUtil _storageUtil;
  final SpUtil _spUtil;

  StorageDataRepository(this._storageUtil, this._spUtil);

  @override
  Future<List<Point>> loadPoints() {
    return _storageUtil.loadPoints();
  }

  @override
  Future<void> savePoints(List<Point> points) {
    return _storageUtil.savePoints(points);
  }

  @override
  Future<List<String>> loadPaymentHistory() {
    return _storageUtil.loadPaymentsHistory();
  }

  @override
  Future<void> savePaymentHistory({required List<String> history}) {
    return _storageUtil.savePaymentsHistory(history);
  }

  @override
  Future<List<Subscription>> loadSubscriptions() {
    return _storageUtil.loadSubscriptions();
  }

  @override
  Future<void> saveSubscriptions({required List<Subscription> subscriptions}) {
    return _storageUtil.saveSubscriptions(subscriptions);
  }

  @override
  Future<bool> isShowSubscriptionDialog() {
    return _spUtil.isShowSubscriptionDialog();
  }

  @override
  Future<bool> setShowSubscriptionDialog(bool value) {
    return _spUtil.setShowSubscriptionDialog(value);
  }
}
