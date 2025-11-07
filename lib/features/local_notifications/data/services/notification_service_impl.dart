import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:baza_gibdd_gai/features/local_notifications/domain/services/i_notification_service.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/controllers/message_payload_handler.dart';
import 'package:baza_gibdd_gai/main.dart';

class NotificationServiceImpl implements INotificationService {
  final FlutterLocalNotificationsPlugin _plugin;
  bool _initialized = false;

  NotificationServiceImpl(this._plugin);

  @override
  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;

    const androidSettings = AndroidInitializationSettings('app_icon');
    final DarwinInitializationSettings initializationSettingsDarwin =
        const DarwinInitializationSettings();
    final settings = InitializationSettings(
      android: androidSettings,
      iOS: initializationSettingsDarwin,
    );

    final launchDetails = await _plugin.getNotificationAppLaunchDetails();

    if (launchDetails?.didNotificationLaunchApp ?? false) {
      payloadToHandle = launchDetails?.notificationResponse?.payload;
    }

    Logger().i(
      'Launched from notification: ${launchDetails?.didNotificationLaunchApp}',
    );
    Logger().i('Payload: ${launchDetails?.notificationResponse?.payload}');

    await _plugin.initialize(
      settings,
      onDidReceiveNotificationResponse: (response) {
        handleNotificationTap(response.payload);
      },
    );
  }

  @override
  bool get isInitialized => _initialized;
}
