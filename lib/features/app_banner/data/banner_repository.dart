import 'package:baza_gibdd_gai/features/app_banner/data/banner_mapper.dart';
import 'package:baza_gibdd_gai/features/app_banner/data/banner_utils.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';

class AppBannerRepository {
  final AppBannerUtil _apiUtil;

  AppBannerRepository(this._apiUtil);

  Future<List<AppBanner>> getAppBanner() async {
    List<AppBanner> result = [];

    final response = await _apiUtil.getAppBanner();
    for (var element in response) {
      if (element.image != null && element.url != null) {
        result.add(BannerMapper.fromApi(element));
      }
    }
    return result;
  }
}
