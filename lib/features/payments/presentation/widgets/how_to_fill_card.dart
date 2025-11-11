import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

class HowToFillCard extends StatelessWidget {
  final String type;
  final String? title;
  final Color? backgroundColor;
  final Color? iconColor;
  final AssetGenImage? image;
  const HowToFillCard(
      {required this.type,
      this.title,
      this.image,
      super.key,
      this.backgroundColor,
      this.iconColor});

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        options: RoundedRectDottedBorderOptions(
            radius: Radius.circular(20),
            dashPattern: [10, 5],
            strokeWidth: 2,
            color: ColorStyles.lightblue),
        child: AppCardLayout(
          padding: EdgeInsets.all(16.w),
          color: backgroundColor ?? const Color(0xffB6FFC4),
          gradient: ColorStyles.cardGradient,
          child: Column(
            children: [
              Row(
                children: [
                  /*  Assets.icons.messageIcon.svg(
                      colorFilter: ColorFilter.mode(
                          iconColor ?? const Color(0xff1EA93D),
                          BlendMode.srcIn)),
                  SizedBox(width: 12.w), */
                  Flexible(
                    child: Text(
                        'Подсказка:'
                            .toUpperCase() /* title ?? 'Памятка по заполнению' */,
                        style: TextStyles.h2.copyWith(
                            color: iconColor ?? Colors.black,
                            fontSize: 24.sp,
                            height: 1,
                            fontFamily: 'Oswald',
                            fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
              if (fillHint[type] != null) ...[
                SizedBox(height: 9.h),
                Text(
                  fillHint[type]!,
                  style: TextStyles.h4.copyWith(
                      color: iconColor ?? Colors.black.withValues(alpha: 0.8)),
                ),
              ],
              if (image != null)
                Padding(
                    padding: EdgeInsets.only(top: 20.h), child: image!.image())
            ],
          ),
        ));
  }
}
