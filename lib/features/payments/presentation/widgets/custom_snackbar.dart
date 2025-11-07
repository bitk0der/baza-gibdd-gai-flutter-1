import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';

class CustomSnackbar {
  static void show(
    BuildContext context,
    GlobalKey<ScaffoldState> scaffoldKey, {
    required String text,
  }) {
    final snackBar = SnackBar(
        duration: const Duration(seconds: 2),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        backgroundColor: Colors.white,
        content: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(
              Icons.error_outline,
              size: 60.w,
              color: ColorStyles.primaryBlue,
            ),
            SizedBox(width: 20.w),
            Expanded(
              child: Text(
                text,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.sp,
                  color: ColorStyles.primaryBlue,
                ),
              ),
            )
          ],
        ));
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
    // scaffoldKey.currentState.hideCurrentSnackBar();
    // scaffoldKey.currentState.showSnackBar(snackBar);
  }
}
