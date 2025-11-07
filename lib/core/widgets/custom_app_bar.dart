import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar {
  static PreferredSize getAppBarWithLogo({
    List<Widget>? actions,
    required String title,
    String? subtitle,
    required BuildContext context,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 10.h),
      child: Container(
        /*  decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.mainAppbarImageBackground.path),
            fit: BoxFit.cover,
          ),
        ), */
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Row(
                children: [
                  AppCircleButton(
                    onTap: () => context.maybePop(),
                    icon: Assets.icons.navBarIcons.chatNavBarIcon,
                    buttonSize: 40,
                    backgroundColor: Colors.white,
                  ),
                  SizedBox(width: 10.w),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyles.h1.copyWith(fontSize: 20.sp),
                        ),
                        Visibility(
                          visible: subtitle != null,
                          child: Text(
                            subtitle ?? '',
                            style: TextStyles.h5.copyWith(
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: actions,
          leading: const SizedBox.shrink(),
        ),
      ),
    );
  }

  static PreferredSize getAppBar({
    List<Widget>? actions,
    bool isBackButton = true,
    VoidCallback? onTapBackButton,
    bool isNeedImage = false,
    double borderRadius = 16,
    required String title,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 20.h),
      child: Container(
        decoration: BoxDecoration(
          image: !isNeedImage
              ? null
              : DecorationImage(
                  image: AssetImage(Assets.images.backgroundImage.path),
                  fit: BoxFit.cover,
                ),
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(borderRadius),
          ),
        ),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.vertical(
              bottom: Radius.circular(16),
            ),
          ),
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        if (isBackButton) ...[
                          AppCircleButton(
                            buttonSize: 44,
                            onTap: onTapBackButton,
                            padding: 12,
                            radius: 12,
                            icon: Assets.icons.navBarIcons.chatNavBarIcon,
                            backgroundColor: Colors.white24,
                            iconColor: Colors.white,
                          ),
                          SizedBox(width: 16.w),
                        ],
                        Flexible(
                          child: Text(
                            title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyles.h1.copyWith(
                              fontSize: 18.sp,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (actions != null) ...actions,
                ],
              ),
            ),
          ),
          actions: const [],
          leading: const SizedBox.shrink(),
        ),
      ),
    );
  }

  static PreferredSize getAppBarResult({
    List<Widget>? actions,
    bool isBackButton = true,
    bool result = true,
    VoidCallback? onTapBackButton,
    required String title,
  }) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 20.h),
      child: AppBar(
        elevation: 0,
        backgroundColor: ColorStyles.black,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.vertical(
            bottom: Radius.circular(20),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size.zero,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    if (isBackButton) ...[
                      AppCircleButton(
                        onTap: onTapBackButton,
                        icon: Assets.icons.navBarIcons.chatNavBarIcon,
                        backgroundColor: Colors.white24,
                        iconColor: Colors.white,
                      ),
                      SizedBox(width: 16.w),
                    ],
                    Text(
                      title,
                      style: TextStyles.h1.copyWith(
                        fontSize: 18.sp,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                if (actions != null) ...actions,
              ],
            ),
          ),
        ),
        actions: const [],
        leading: const SizedBox.shrink(),
      ),
    );
  }

  static PreferredSize getAppBarWithoutBackButton({required String title}) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 14.h),
      child: Container(
        /*  decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Assets.images.mainAppbarImageBackground.path),
            fit: BoxFit.cover,
          ),
          border: Border(
            bottom: BorderSide(color: Colors.white.withValues(alpha: 0.2)),
          ),
        ), */
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          bottom: PreferredSize(
            preferredSize: Size.zero,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyles.h1.copyWith(fontSize: 20.sp),
              ),
            ),
          ),
          actions: [],
          leading: const SizedBox.shrink(),
        ),
      ),
    );
  }

  static PreferredSize getDefaultAppBar(
    String title,
    BuildContext context, [
    isCentered = false,
    String? imagePath,
  ]) {
    return PreferredSize(
      preferredSize: Size.fromHeight(kToolbarHeight + 10.h),
      child: Container(
        decoration: BoxDecoration(
          color: ColorStyles.white,
          image: DecorationImage(
            image: AssetImage(
              imagePath ?? Assets.images.backgroundImage.path,
            ),
            fit: BoxFit.cover,
          ),
          borderRadius: const BorderRadius.vertical(bottom: Radius.circular(0)),
          border: const Border(bottom: BorderSide(color: Colors.white10)),
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                AppCircleButton(
                  quarterTurns: 2,
                  icon: Assets.icons.navBarIcons.chatNavBarIcon,
                  onTap: () => context.maybePop(),
                  backgroundColor: Colors.white24,
                  iconColor: Colors.white,
                ),
                SizedBox(width: 16.w),
                Flexible(
                  child: Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyles.h2.copyWith(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
