import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_colors.dart';

class TextStyles {
  static String fontFamily = 'Roboto';
  static double textHeight = 1.2;

  static TextStyle h2 = TextStyle(
    color: ColorStyles.white,
    fontWeight: FontWeight.w600,
    fontFamily: fontFamily,
    fontSize: 18.sp,
  );
}
