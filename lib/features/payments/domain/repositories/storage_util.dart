import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_point.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_subscription.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/mapper/point_mapper.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/mapper/subscription_mapper.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/point.dart';
import 'package:json_store/json_store.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/subscription.dart';

@injectable
class StorageUtil {
  final _jsonStore = JsonStore();

  Future<List<Point>> loadPoints() async {
    List<Map<String, dynamic>>? json = await _jsonStore.getListLike('point-%');
    List<Point> pointsList = [];
    if (json != null) {
      for (var element in json) {
        pointsList.add(PointMapper.fromApi(ApiPoint.fromMap(element)));
      }
    }
    return pointsList;
  }

  Future<void> savePoints(List<Point> points) async {
    final batch = await _jsonStore.startBatch();
    JsonStore().deleteLike('point-%', batch: batch);
    for (int i = 0; i < points.length; i++) {
      await JsonStore().setItem(
        'point-$i',
        PointMapper.toApi(points[i]).toMap(),
        batch: batch,
      );
    }
    _jsonStore.commitBatch(batch);
  }

  Future<void> savePaymentsHistory(List<String> history) async {
    final batch = await JsonStore().startBatch();
    JsonStore().deleteLike('payment-%', batch: batch);
    for (int i = 0; i < history.length; i++) {
      await JsonStore().setItem(
        'payment-$i',
        {'invoiceId': history[i]},
        batch: batch,
      );
    }
    JsonStore().commitBatch(batch);
  }

  Future<List<String>> loadPaymentsHistory() async {
    List<Map<String, dynamic>>? json =
        await JsonStore().getListLike('payment-%');
    List<String> history = [];
    if (json != null) {
      for (var element in json) {
        history.add(element['invoiceId']);
      }
    }
    return history;
  }

  Future<void> saveSubscriptions(List<Subscription> subscriptions) async {
    final batch = await JsonStore().startBatch();
    JsonStore().deleteLike('subscription-%', batch: batch);
    for (int i = 0; i < subscriptions.length; i++) {
      await JsonStore().setItem(
        'subscription-$i',
        SubscriptionMapper.toApi(subscriptions[i]).toMap(),
        batch: batch,
      );
    }
    JsonStore().commitBatch(batch);
  }

  Future<List<Subscription>> loadSubscriptions() async {
    List<Map<String, dynamic>>? json =
        await JsonStore().getListLike('subscription-%');
    List<Subscription> subscriptionsList = [];
    if (json != null) {
      for (var element in json) {
        subscriptionsList
            .add(SubscriptionMapper.fromApi(ApiSubscription.fromMap(element)));
      }
    }
    return subscriptionsList;
  }
}
