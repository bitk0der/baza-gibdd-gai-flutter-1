import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/banner_click_handler.dart';

class AppSingleBannerWidget extends StatelessWidget {
  final AppBanner appBanner;
  final double width;
  final bool isVertical;
  const AppSingleBannerWidget({
    super.key,
    required this.appBanner,
    required this.width,
    required this.isVertical,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: isVertical
          ? EdgeInsets.only(bottom: 10.h)
          : EdgeInsets.only(right: 12.h),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
      child: GestureDetector(
        onTap: () => BannerClickHandler.bannerClickHandler(context, appBanner),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: CachedNetworkImage(
            imageUrl: appBanner.image,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              width: double.maxFinite,
              // height: 120.h,
              color: Colors.grey,
              child: Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Colors.white,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: double.maxFinite,
              // height: 120.h,
              color: Colors.grey,
              child: const Center(child: Icon(Icons.image, size: 36)),
            ),
          ),
        ),
      ),
    );
  }
}
