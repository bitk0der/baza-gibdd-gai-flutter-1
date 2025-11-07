import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:baza_gibdd_gai/features/background_fetch/background_fetch_callback.dart';
import 'package:baza_gibdd_gai/features/background_fetch/background_fetch_service.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/services/notification_service_impl.dart';
import 'package:baza_gibdd_gai/features/local_notifications/domain/services/i_notification_service.dart';

final FlutterLocalNotificationsPlugin notifications =
    FlutterLocalNotificationsPlugin();

Future<void> connectNotificationsLogic() async {
  INotificationService notificationService = NotificationServiceImpl(
    notifications,
  );
  await notificationService.init();

  final result = await notifications
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.requestNotificationsPermission();

  if (result == null || result == true) {
    await BackgroundFetchService.init();
    await BackgroundFetch.registerHeadlessTask(backgroundFetchHeadlessTask);
  }
}
