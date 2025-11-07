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
    List<PageRouteInfo>? children,
  }) : super(
          AppWebViewPage.name,
          args: AppWebViewPageArgs(
            key: key,
            url: url,
            title: title,
            isNeedBackButton: isNeedBackButton,
            appBar: appBar,
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
  });

  final Key? key;

  final String url;

  final String title;

  final bool isNeedBackButton;

  final PreferredSizeWidget? appBar;

  @override
  String toString() {
    return 'AppWebViewPageArgs{key: $key, url: $url, title: $title, isNeedBackButton: $isNeedBackButton, appBar: $appBar}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! AppWebViewPageArgs) return false;
    return key == other.key &&
        url == other.url &&
        title == other.title &&
        isNeedBackButton == other.isNeedBackButton &&
        appBar == other.appBar;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      url.hashCode ^
      title.hashCode ^
      isNeedBackButton.hashCode ^
      appBar.hashCode;
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
