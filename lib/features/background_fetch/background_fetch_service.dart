import 'package:background_fetch/background_fetch.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:logger/logger.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/data/repositories/api_repository.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/blocs/chat_cubit.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/services/notification_service_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BackgroundFetchService {
  static Future<void> init() async {
    await BackgroundFetch.configure(
      BackgroundFetchConfig(
        minimumFetchInterval: 15,
        stopOnTerminate: false,
        startOnBoot: true,
        requiredNetworkType: NetworkType.ANY,
        enableHeadless: true,
      ),
      onFetch,
      onTimeout,
    );
  }

  static Future<void> onFetch(String taskId) async {
    Logger().i('[BackgroundFetch] Task received: $taskId');

    final notificationsPlugin = FlutterLocalNotificationsPlugin();
    final service = NotificationServiceImpl(notificationsPlugin);
    await service.init();
    final ApiRepository apiRepository = ApiRepository();
    final SharedPreferences preferences = await SharedPreferences.getInstance();

    final bloc = ChatCubit(
      repository: apiRepository,
      preferences: preferences,
    ); // Replace with actual preferences if needed
    bloc.getLastMessage(isNotification: true);

    await Future.delayed(const Duration(seconds: 3));
    BackgroundFetch.finish(taskId);
  }

  static Future<void> onTimeout(String taskId) async {
    Logger().w('[BackgroundFetch] Task timeout: $taskId');
    BackgroundFetch.finish(taskId);
  }
}
