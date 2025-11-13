import 'package:baza_gibdd_gai/core/widgets/app_gradient_svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

class EmptySearchPlaceholder extends StatelessWidget {
  const EmptySearchPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.images.emptyLoans.path),
              fit: BoxFit.cover)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 30.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /* Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
                    decoration: BoxDecoration(
                        color: ColorStyles.green,
                        borderRadius: BorderRadius.circular(16.r)),
                    child: Text('Поздравляем!',
                        style: TextStyles.h2.copyWith(fontSize: 20.sp)),
                  ), */

                  SizedBox(height: 20.h),
                  SizedBox(
                    width: 60.w,
                    height: 60.w,
                    child: AppGradientSvgIcon(
                        gradient: ColorStyles.blueIconGradient,
                        icon: Assets.icons.verifiedShieldNonOpacity),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'У вас нет неоплаченных начислений'.toUpperCase(),
                    style: TextStyle(
                      fontSize: 34.sp,
                      height: 1.1,
                      color: ColorStyles.white,
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'Подпишитесь на уведомления по заданным параметрам и вы первым узнаете, как появится новая задолженность',
                    style: TextStyle(
                      fontSize: 20.sp,
                      height: 1.1,
                      color: ColorStyles.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )),
          /*  Align(
              alignment: Alignment.bottomCenter,
              child: Assets.images.emptyLoans.image()), */
        ],
      ),
    );
  }
}
