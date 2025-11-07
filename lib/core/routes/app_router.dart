import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/core/app_root_screen.dart';
import 'package:baza_gibdd_gai/features/home/presentation/pages/home_screen.dart';

part 'app_router.gr.dart';

@singleton
@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes {
    return [
      AutoRoute(
        initial: true,
        path: '/',
        page: AppRootRoute.page,
        children: [
          AutoRoute(
            page: HomeRouter.page,
            path: 'home',
            children: [AutoRoute(page: HomeRoute.page, path: '')],
          ),
        ],
      ),
    ];
  }
}

@RoutePage(name: 'HomeRouter')
class HomeRouterPage extends AutoRouter {
  const HomeRouterPage({super.key});
}
