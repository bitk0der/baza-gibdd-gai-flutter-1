import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(
    NavigationResolver resolver,
    StackRouter router,
  ) async {
    final prefs = GetIt.I<SharedPreferences>();
    final isFirstLaunch = prefs.getBool('first_launch') ?? true;

    if (isFirstLaunch) {
      router.navigate(const OnboardingRoute());
    } else {
      resolver.next(true);
    }
  }
}
