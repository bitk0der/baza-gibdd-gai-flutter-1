import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';
import 'package:url_launcher/url_launcher.dart';

class BannerClickHandler {
  static void bannerClickHandler(BuildContext context, AppBanner banner) {
    if (banner.url == '/chat') {
      context.navigateTo(const HomeChatRoute());
    } else if (banner.url.startsWith('/')) {
      context.navigateNamedTo(banner.url);
    } else if (banner.isExternal && banner.url.contains('https')) {
      launchUrl(
        Uri.parse(banner.url.replaceAll('USER_ID', 'globalUserId')),
        mode: LaunchMode.externalApplication,
      );
    } else {
      context.router.push(AppWebViewPage(title: banner.title, url: banner.url));
    }
  }
}
