// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [AppRootScreen]
class AppRootRoute extends PageRouteInfo<void> {
  const AppRootRoute({List<PageRouteInfo>? children})
      : super(AppRootRoute.name, initialChildren: children);

  static const String name = 'AppRootRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AppRootScreen();
    },
  );
}

/// generated route for
/// [AppWebView]
class AppWebViewPage extends PageRouteInfo<AppWebViewPageArgs> {
  AppWebViewPage({
    Key? key,
    String url = '',
    String title = '',
    bool isNeedBackButton = true,
    PreferredSizeWidget? appBar,
    VoidCallback? onFinished,
    List<PageRouteInfo>? children,
  }) : super(
          AppWebViewPage.name,
          args: AppWebViewPageArgs(
            key: key,
            url: url,
            title: title,
            isNeedBackButton: isNeedBackButton,
            appBar: appBar,
            onFinished: onFinished,
          ),
          initialChildren: children,
        );

  static const String name = 'AppWebViewPage';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<AppWebViewPageArgs>(
        orElse: () => const AppWebViewPageArgs(),
      );
      return AppWebView(
        key: args.key,
        url: args.url,
        title: args.title,
        isNeedBackButton: args.isNeedBackButton,
        appBar: args.appBar,
        onFinished: args.onFinished,
      );
    },
  );
}

class AppWebViewPageArgs {
  const AppWebViewPageArgs({
    this.key,
    this.url = '',
    this.title = '',
    this.isNeedBackButton = true,
    this.appBar,
    this.onFinished,
  });

  final Key? key;

  final String url;

  final String title;

  final bool isNeedBackButton;

  final PreferredSizeWidget? appBar;

  final VoidCallback? onFinished;

  @override
  String toString() {
    return 'AppWebViewPageArgs{key: $key, url: $url, title: $title, isNeedBackButton: $isNeedBackButton, appBar: $appBar, onFinished: $onFinished}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppWebViewPageArgs) return false;
    return key == other.key &&
        url == other.url &&
        title == other.title &&
        isNeedBackButton == other.isNeedBackButton &&
        appBar == other.appBar &&
        onFinished == other.onFinished;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      url.hashCode ^
      title.hashCode ^
      isNeedBackButton.hashCode ^
      appBar.hashCode ^
      onFinished.hashCode;
}

/// generated route for
/// [BackgroundNotificationsScreen]
class BackgroundNotificationsRoute extends PageRouteInfo<void> {
  const BackgroundNotificationsRoute({List<PageRouteInfo>? children})
      : super(BackgroundNotificationsRoute.name, initialChildren: children);

  static const String name = 'BackgroundNotificationsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const BackgroundNotificationsScreen();
    },
  );
}

/// generated route for
/// [ChatRouterPage]
class ChatRouter extends PageRouteInfo<void> {
  const ChatRouter({List<PageRouteInfo>? children})
      : super(ChatRouter.name, initialChildren: children);

  static const String name = 'ChatRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const ChatRouterPage();
    },
  );
}

/// generated route for
/// [CheckoutPage]
class CheckoutRoute extends PageRouteInfo<CheckoutRouteArgs> {
  CheckoutRoute({
    Key? key,
    required List<String> serviceParams,
    required AvailableProduct availableProduct,
    List<PageRouteInfo>? children,
  }) : super(
          CheckoutRoute.name,
          args: CheckoutRouteArgs(
            key: key,
            serviceParams: serviceParams,
            availableProduct: availableProduct,
          ),
          initialChildren: children,
        );

  static const String name = 'CheckoutRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CheckoutRouteArgs>();
      return CheckoutPage(
        key: args.key,
        serviceParams: args.serviceParams,
        availableProduct: args.availableProduct,
      );
    },
  );
}

class CheckoutRouteArgs {
  const CheckoutRouteArgs({
    this.key,
    required this.serviceParams,
    required this.availableProduct,
  });

  final Key? key;

  final List<String> serviceParams;

  final AvailableProduct availableProduct;

  @override
  String toString() {
    return 'CheckoutRouteArgs{key: $key, serviceParams: $serviceParams, availableProduct: $availableProduct}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CheckoutRouteArgs) return false;
    return key == other.key &&
        const ListEquality<String>().equals(
          serviceParams,
          other.serviceParams,
        ) &&
        availableProduct == other.availableProduct;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const ListEquality<String>().hash(serviceParams) ^
      availableProduct.hashCode;
}

/// generated route for
/// [CreditRatingMainOldPage]
class CreditRatingMainOldRoute extends PageRouteInfo<void> {
  const CreditRatingMainOldRoute({List<PageRouteInfo>? children})
      : super(CreditRatingMainOldRoute.name, initialChildren: children);

  static const String name = 'CreditRatingMainOldRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreditRatingMainOldPage();
    },
  );
}

/// generated route for
/// [CreditRatingMainPage]
class CreditRatingMainRoute extends PageRouteInfo<void> {
  const CreditRatingMainRoute({List<PageRouteInfo>? children})
      : super(CreditRatingMainRoute.name, initialChildren: children);

  static const String name = 'CreditRatingMainRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreditRatingMainPage();
    },
  );
}

/// generated route for
/// [FavouritesPage]
class FavouritesRoute extends PageRouteInfo<void> {
  const FavouritesRoute({List<PageRouteInfo>? children})
      : super(FavouritesRoute.name, initialChildren: children);

  static const String name = 'FavouritesRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FavouritesPage();
    },
  );
}

/// generated route for
/// [FillDataPage]
class FillDataRoute extends PageRouteInfo<void> {
  const FillDataRoute({List<PageRouteInfo>? children})
      : super(FillDataRoute.name, initialChildren: children);

  static const String name = 'FillDataRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FillDataPage();
    },
  );
}

/// generated route for
/// [FinePaymentScreen]
class FinePaymentRoute extends PageRouteInfo<void> {
  const FinePaymentRoute({List<PageRouteInfo>? children})
      : super(FinePaymentRoute.name, initialChildren: children);

  static const String name = 'FinePaymentRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FinePaymentScreen();
    },
  );
}

/// generated route for
/// [FineSearchScreen]
class FineSearchRoute extends PageRouteInfo<FineSearchRouteArgs> {
  FineSearchRoute({
    Key? key,
    required UserData userData,
    bool isFromPush = false,
    List<PageRouteInfo>? children,
  }) : super(
          FineSearchRoute.name,
          args: FineSearchRouteArgs(
            key: key,
            userData: userData,
            isFromPush: isFromPush,
          ),
          initialChildren: children,
        );

  static const String name = 'FineSearchRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<FineSearchRouteArgs>();
      return FineSearchScreen(
        key: args.key,
        userData: args.userData,
        isFromPush: args.isFromPush,
      );
    },
  );
}

class FineSearchRouteArgs {
  const FineSearchRouteArgs({
    this.key,
    required this.userData,
    this.isFromPush = false,
  });

  final Key? key;

  final UserData userData;

  final bool isFromPush;

  @override
  String toString() {
    return 'FineSearchRouteArgs{key: $key, userData: $userData, isFromPush: $isFromPush}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! FineSearchRouteArgs) return false;
    return key == other.key &&
        userData == other.userData &&
        isFromPush == other.isFromPush;
  }

  @override
  int get hashCode => key.hashCode ^ userData.hashCode ^ isFromPush.hashCode;
}

/// generated route for
/// [FinesRouterPage]
class FinesRouter extends PageRouteInfo<void> {
  const FinesRouter({List<PageRouteInfo>? children})
      : super(FinesRouter.name, initialChildren: children);

  static const String name = 'FinesRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const FinesRouterPage();
    },
  );
}

/// generated route for
/// [HomeChatScreen]
class HomeChatRoute extends PageRouteInfo<void> {
  const HomeChatRoute({List<PageRouteInfo>? children})
      : super(HomeChatRoute.name, initialChildren: children);

  static const String name = 'HomeChatRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeChatScreen();
    },
  );
}

/// generated route for
/// [HomeRouterPage]
class HomeRouter extends PageRouteInfo<void> {
  const HomeRouter({List<PageRouteInfo>? children})
      : super(HomeRouter.name, initialChildren: children);

  static const String name = 'HomeRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeRouterPage();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [MyReportsRouterPage]
class MyReportsRouter extends PageRouteInfo<void> {
  const MyReportsRouter({List<PageRouteInfo>? children})
      : super(MyReportsRouter.name, initialChildren: children);

  static const String name = 'MyReportsRouter';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MyReportsRouterPage();
    },
  );
}

/// generated route for
/// [NotificationDetailsPage]
class NotificationDetailsRoute
    extends PageRouteInfo<NotificationDetailsRouteArgs> {
  NotificationDetailsRoute({
    Key? key,
    required MessagesResponse messageResponse,
    List<PageRouteInfo>? children,
  }) : super(
          NotificationDetailsRoute.name,
          args: NotificationDetailsRouteArgs(
            key: key,
            messageResponse: messageResponse,
          ),
          initialChildren: children,
        );

  static const String name = 'NotificationDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<NotificationDetailsRouteArgs>();
      return NotificationDetailsPage(
        key: args.key,
        messageResponse: args.messageResponse,
      );
    },
  );
}

class NotificationDetailsRouteArgs {
  const NotificationDetailsRouteArgs({this.key, required this.messageResponse});

  final Key? key;

  final MessagesResponse messageResponse;

  @override
  String toString() {
    return 'NotificationDetailsRouteArgs{key: $key, messageResponse: $messageResponse}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! NotificationDetailsRouteArgs) return false;
    return key == other.key && messageResponse == other.messageResponse;
  }

  @override
  int get hashCode => key.hashCode ^ messageResponse.hashCode;
}

/// generated route for
/// [OnboardingScreen]
class OnboardingRoute extends PageRouteInfo<void> {
  const OnboardingRoute({List<PageRouteInfo>? children})
      : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const OnboardingScreen();
    },
  );
}

/// generated route for
/// [PaymentHistoryScreen]
class PaymentHistoryRoute extends PageRouteInfo<void> {
  const PaymentHistoryRoute({List<PageRouteInfo>? children})
      : super(PaymentHistoryRoute.name, initialChildren: children);

  static const String name = 'PaymentHistoryRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PaymentHistoryScreen();
    },
  );
}

/// generated route for
/// [PaymentWebviewPage]
class PaymentWebviewRoute extends PageRouteInfo<PaymentWebviewRouteArgs> {
  PaymentWebviewRoute({
    Key? key,
    required Cart cart,
    List<PageRouteInfo>? children,
  }) : super(
          PaymentWebviewRoute.name,
          args: PaymentWebviewRouteArgs(key: key, cart: cart),
          initialChildren: children,
        );

  static const String name = 'PaymentWebviewRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<PaymentWebviewRouteArgs>();
      return PaymentWebviewPage(key: args.key, cart: args.cart);
    },
  );
}

class PaymentWebviewRouteArgs {
  const PaymentWebviewRouteArgs({this.key, required this.cart});

  final Key? key;

  final Cart cart;

  @override
  String toString() {
    return 'PaymentWebviewRouteArgs{key: $key, cart: $cart}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! PaymentWebviewRouteArgs) return false;
    return key == other.key && cart == other.cart;
  }

  @override
  int get hashCode => key.hashCode ^ cart.hashCode;
}

/// generated route for
/// [PaymentsScreen]
class PaymentsRoute extends PageRouteInfo<void> {
  const PaymentsRoute({List<PageRouteInfo>? children})
      : super(PaymentsRoute.name, initialChildren: children);

  static const String name = 'PaymentsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const PaymentsScreen();
    },
  );
}
