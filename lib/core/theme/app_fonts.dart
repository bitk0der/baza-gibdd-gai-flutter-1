import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class TextStyles {
  static String fontFamily = 'SFProDisplay';
  static double textHeight = 1.1;

  static TextStyle h1 = TextStyle(
    color: ColorStyles.white,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    height: 1.1,
    fontSize: 20.sp,
  );
  static TextStyle h2 = TextStyle(
    color: ColorStyles.white,
    fontWeight: FontWeight.w700,
    fontFamily: fontFamily,
    height: textHeight,
    fontSize: 17.sp,
  );
  static TextStyle h3 = TextStyle(
    color: ColorStyles.white,
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
    fontFamily: fontFamily,
    height: 1.2,
  );

  static TextStyle h4 = TextStyle(
    color: ColorStyles.white,
    fontWeight: FontWeight.w400,
    fontSize: 15.sp,
    fontFamily: fontFamily,
    height: textHeight,
  );
  static TextStyle h5 = TextStyle(
    color: ColorStyles.white,
    fontWeight: FontWeight.w400,
    fontSize: 14.sp,
    fontFamily: fontFamily,
    height: textHeight,
  );
}
