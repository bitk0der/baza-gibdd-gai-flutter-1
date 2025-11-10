import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/routes/onboarding_guard.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_web_view.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/pages/favourites_page.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/pages/home_chat_screen.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/pages/introduction_screen.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/payment_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/product_model.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/pages/checkout_page.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/pages/credit_rating_main_page.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/pages/credit_rating_main_page_old.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/pages/fill_data_page.dart';
import 'package:baza_gibdd_gai/features/credit_rating/presentation/pages/payment_webview.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/pages/notification_details_page.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/user_data.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/pages/fine/fine_payment_screen.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/pages/fine/fine_search_screen.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/pages/payment_history_screen/payment_history_screen.dart'
    show PaymentHistoryScreen;
import 'package:baza_gibdd_gai/features/payments/presentation/pages/payment_screen.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/app_root_screen.dart';
import 'package:baza_gibdd_gai/features/home/presentation/pages/home_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  AppRouter(GlobalKey<NavigatorState>? navigatorKey)
      : super(navigatorKey: navigatorKey);
  final onboardingGuard = OnboardingGuard();
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
            children: [
              AutoRoute(page: HomeRoute.page, path: ''),
              AutoRoute(page: AppWebViewPage.page, path: 'app_webview'),
              AutoRoute(page: FillDataRoute.page, path: 'fill_data_route'),
            ],
          ),
          AutoRoute(
            page: FinesRouter.page,
            path: 'fines',
            children: [AutoRoute(page: PaymentsRoute.page, path: '')],
          ),
          AutoRoute(
            page: ChatRouter.page,
            path: 'chat',
            children: [
              AutoRoute(page: OnboardingRoute.page),
              AutoRoute(
                  page: HomeChatRoute.page,
                  guards: [onboardingGuard],
                  path: ''),
              AutoRoute(page: AppWebViewPage.page, path: 'app_webview'),
            ],
          ),
          AutoRoute(
            page: MyReportsRouter.page,
            path: 'my_reports',
            children: [
              AutoRoute(page: CreditRatingMainRoute.page, path: ''),
              AutoRoute(
                page: CreditRatingMainOldRoute.page,
                path: 'credit_rating_main_page_old',
              ),
              AutoRoute(page: CheckoutRoute.page, path: 'checkout_route'),
              AutoRoute(page: FillDataRoute.page, path: 'fill_data_route'),
              AutoRoute(
                page: PaymentWebviewRoute.page,
                path: 'payment_app_webview',
              ),
              AutoRoute(page: AppWebViewPage.page, path: 'app_webview'),
            ],
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

@RoutePage(name: 'FinesRouter')
class FinesRouterPage extends AutoRouter {
  const FinesRouterPage({super.key});
}

@RoutePage(name: 'ChatRouter')
class ChatRouterPage extends AutoRouter {
  const ChatRouterPage({super.key});
}

@RoutePage(name: 'MyReportsRouter')
class MyReportsRouterPage extends AutoRouter {
  const MyReportsRouterPage({super.key});
}
