import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';

class TabButton extends StatefulWidget {
  final bool isActive;
  final String text;
  final VoidCallback onTap;
  const TabButton(
      {required this.isActive,
      required this.onTap,
      required this.text,
      super.key});

  @override
  State<TabButton> createState() => _TabButtonState();
}

class _TabButtonState extends State<TabButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: widget.onTap,
      child: AnimatedContainer(
        width: double.infinity,
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 13.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: widget.isActive
              ? LinearGradient(colors: ColorStyles.blueTabBarGradient)
              : null,
          color: widget.isActive ? ColorStyles.blue : Colors.transparent,
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 300),
          textAlign: TextAlign.center,
          style: TextStyles.h4.copyWith(
              color: widget.isActive
                  ? Colors.white
                  : ColorStyles.white.withValues(alpha: 0.5)),
          child: Text(widget.text),
        ),
      ),
    );
  }
}
