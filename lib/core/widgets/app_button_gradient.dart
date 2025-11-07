import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButtonGradient extends StatelessWidget {
  final String? title;
  final Color backgroundColor;
  final Color titleColor;
  final TextStyle? titleStyle;
  final double borderRadius;
  final VoidCallback? onTap;
  final double height;
  final bool isLoading;
  final EdgeInsets margin;
  final Widget? child;
  final List<Color>? gradient;
  const AppButtonGradient({
    super.key,
    this.title,
    this.backgroundColor = ColorStyles.blue,
    this.titleColor = ColorStyles.white,
    this.onTap,
    this.borderRadius = 16,
    this.isLoading = false,
    this.height = 46,
    this.margin = EdgeInsets.zero,
    this.child,
    this.titleStyle,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: margin,
      decoration: BoxDecoration(
        color: backgroundColor,
        gradient: gradient == null
            ? null
            : LinearGradient(
                colors: gradient!,
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      child: TextButton(
        onPressed: isLoading ? null : onTap,
        style: TextButton.styleFrom(
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
                    style: titleStyle ??
                        TextStyles.h2.copyWith(
                          color: titleColor,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                        ),
                  ),
        ),
      ),
    );
  }
}
