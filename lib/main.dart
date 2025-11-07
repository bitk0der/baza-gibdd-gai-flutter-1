import 'package:baza_gibdd_gai/core/di/service_locator.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/theme.dart';
import 'package:baza_gibdd_gai/core/utils/random_string_generator.dart';
import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/local_notifications/main_notification_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:appmetrica_plugin/appmetrica_plugin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';

var globalUserId = '';

/* AppMetricaConfig get _config =>
    const AppMetricaConfig(ApiPath.appMetrikaConfigKey, logs: false); */
final appNavigatorKey = GlobalKey<NavigatorState>();
final _appRouter = AppRouter(appNavigatorKey);
String? payloadToHandle;

void main() async {
  AppMetrica.runZoneGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    /*  await AppMetrica.activate(_config); */
    await EasyLocalization.ensureInitialized();

    await initServiceLocator();
    await AppBannerInitialSetup().getPackageInfo();
    await AppBannerInitialSetup().getBanner();
    await connectNotificationsLogic();
    var userId = await AppMetrica.deviceId;
    if (GetIt.I<SharedPreferences>().getString('userIdMetrika') == null) {
      await GetIt.I<SharedPreferences>().setString(
        'userIdMetrika',
        userId ?? generateRandomString(),
      );
    }

    globalUserId = userId ?? generateRandomString();

    runApp(
      EasyLocalization(
        supportedLocales: const [Locale('ru', 'RU'), Locale('en', 'US')],
        path: 'assets/translations',
        fallbackLocale: const Locale('en', 'US'),
        child: const App(),
      ),
    );
  });
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ScreenUtilInit(
        designSize: const Size(414, 896),
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          routerConfig: _appRouter.config(),
          theme: defaultTheme,
        ),
      ),
    );
  }
}
