import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckTile extends StatelessWidget {
  final SvgGenImage icon;
  final String title;
  final VoidCallback? onTap;
  final Widget? customIcon;
  const CheckTile({
    super.key,
    required this.icon,
    required this.title,
    this.onTap,
    this.customIcon,
  });

  @override
  Widget build(BuildContext context) {
    return AppCardLayout(
      onTap: onTap,
      gradient: ColorStyles.mainGradient,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          customIcon ??
              AppCircleButton(
                icon: icon,
                radius: 100,
                iconColor: ColorStyles.blue,
              ),
          SizedBox(height: 10),
          Text(
            title,
            style: TextStyles.h3.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: customIcon != null ? 16.sp : 18.sp,
            ),
          ),
        ],
      ),
    );
  }
}
