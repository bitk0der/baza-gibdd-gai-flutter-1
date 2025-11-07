import 'dart:io';

import 'package:logger/logger.dart';
import 'package:baza_gibdd_gai/features/app_banner/data/banner_repository.dart';
import 'package:baza_gibdd_gai/features/app_banner/data/banner_service.dart';
import 'package:baza_gibdd_gai/features/app_banner/data/banner_utils.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';
import 'package:package_info_plus/package_info_plus.dart';

bool enablePayment = false;
List<AppBanner> bannerList = [];
late PackageInfo packageInfo;

class AppBannerInitialSetup {
  Future<void> updateModerationMod() async {
    if (Platform.isAndroid) {
      enablePayment = true;
      return;
    }
    final appBannerService = AppBannerService();
    try {
      enablePayment = await appBannerService.getModerationModStatus();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> getBanner() async {
    final bannerRepository = AppBannerRepository(
      AppBannerUtil(AppBannerService()),
    );
    try {
      bannerList = await bannerRepository.getAppBanner();
    } catch (e) {
      Logger().e(e);
    }
  }

  Future<void> getPackageInfo() async {
    packageInfo = await PackageInfo.fromPlatform();
  }
}
