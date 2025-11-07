import 'package:baza_gibdd_gai/features/app_banner/data/banner_service.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/api_banner.dart';

class AppBannerUtil {
  final AppBannerService _restService;

  AppBannerUtil(this._restService);

  Future<List<ApiBanner>> getAppBanner() async {
    final response = await _restService.getAppBanner();
    List<ApiBanner> result = [];
    if (response is List) {
      for (var element in response) {
        result.add(ApiBanner.fromMap(element));
      }
    }
    return result;
  }
}
