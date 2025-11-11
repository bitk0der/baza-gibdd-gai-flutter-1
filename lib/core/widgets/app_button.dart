import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String? title;
  final Color? backgroundColor;
  final Color titleColor;
  final TextStyle? titleStyle;
  final double borderRadius;
  final VoidCallback? onTap;
  final double height;
  final double width;
  final bool isLoading;
  final EdgeInsets margin;
  final Widget? child;
  final BoxBorder? boxBorder;
  const AppButton({
    super.key,
    this.title,
    this.backgroundColor,
    this.titleColor = ColorStyles.white,
    this.onTap,
    this.borderRadius = 16,
    this.isLoading = false,
    this.height = 50,
    this.width = double.infinity,
    this.margin = EdgeInsets.zero,
    this.child,
    this.titleStyle,
    this.boxBorder,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: width,
      margin: margin,
      height: height == 50 ? null : height,
      decoration: BoxDecoration(
          color: backgroundColor ?? ColorStyles.secondaryBlue,
          border: boxBorder,
          borderRadius: BorderRadius.circular(borderRadius),
          gradient: backgroundColor == ColorStyles.secondaryBlue
              ? null
              : LinearGradient(colors: ColorStyles.blueTabBarGradient)),
      duration: standartDuration,
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          textStyle: TextStyles.h1.copyWith(fontSize: 20.sp),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: height / 2,
                  width: height / 2,
                  child: CircularProgressIndicator(color: titleColor),
                )
              : child ??
                  Text(
                    title ?? '',
                    textAlign: TextAlign.center,
                    style: titleStyle ??
                        TextStyles.h2.copyWith(
                          color: titleColor,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
        ),
      ),
    );
  }
}
