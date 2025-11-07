import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_web_view.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/pages/favourites_page.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/pages/home_chat_screen.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/pages/notification_details_page.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/app_root_screen.dart';
import 'package:baza_gibdd_gai/features/home/presentation/pages/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(GlobalKey<NavigatorState>? navigatorKey)
      : super(navigatorKey: navigatorKey);
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
