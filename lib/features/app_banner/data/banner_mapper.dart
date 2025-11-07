import 'package:baza_gibdd_gai/features/app_banner/domain/models/api_banner.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';

class BannerMapper {
  static AppBanner fromApi(ApiBanner api) {
    return AppBanner(
      id: api.id,
      url: api.url!,
      image: api.image!,
      title: api.title,
      category: api.category,
      isExternal: api.isExternal,
    );
  }
}
