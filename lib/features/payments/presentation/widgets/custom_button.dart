import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;
  final String title;
  final Widget? child;
  final double? height;
  final Color titleColor;
  final bool isActive;
  final double? borderRadius;

  const CustomButton({
    super.key,
    required this.onTap,
    this.color = ColorStyles.orange,
    required this.title,
    this.child,
    this.height,
    this.borderRadius,
    this.titleColor = Colors.white,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50.h,
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: isActive ? color : Colors.grey.withOpacity(0.8),
        borderRadius: BorderRadius.circular(borderRadius ?? 14),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onPressed: isActive ? onTap : null,
        child: Center(
          child: child ??
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18.sp,
                  color: titleColor,
                ),
              ),
        ),
      ),
    );
  }
}
