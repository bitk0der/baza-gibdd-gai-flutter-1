import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';

abstract class CustomDialog {
  static void show({
    required BuildContext context,
    required String title,
    Widget? widget,
    String? subtitle,
    Color buttonOneColor = ColorStyles.primaryBlue,
    String buttonOneTitle = 'Да',
    VoidCallback? buttonOneOnTap,
    Color buttonTwoColor = ColorStyles.invoiceStatusRed,
    String buttonTwoTitle = 'Нет',
    VoidCallback? buttonTwoOnTap,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(6))),
            backgroundColor: Colors.white,
            content: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontFamily: 'Circie',
                              fontSize: 18.sp,
                              color: ColorStyles.primaryBlue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        InkWell(
                          child: Icon(
                            Icons.close,
                            size: 24.w,
                            color: ColorStyles.primaryBlue,
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ),
                  if (subtitle != null)
                    SizedBox(
                      height: 10.h,
                    ),
                  if (subtitle != null)
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Text(
                        subtitle,
                        style: TextStyle(
                          fontFamily: 'Circie',
                          fontSize: 16.sp,
                          color: ColorStyles.primaryBlue,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  if (widget != null)
                    SizedBox(
                      height: 10.h,
                    ),
                  if (widget != null) widget,
                  SizedBox(
                    height: 20.h,
                  ),
                  _getButton(
                    onTap: () {
                      Navigator.pop(context);
                      if (buttonOneOnTap != null) buttonOneOnTap();
                    },
                    color: buttonOneColor,
                    text: buttonOneTitle,
                  ),
                  _getButton(
                    onTap: () {
                      if (buttonTwoOnTap != null) buttonTwoOnTap();
                      Navigator.pop(context);
                    },
                    color: buttonTwoColor,
                    text: buttonTwoTitle,
                  ),
                ],
              ),
            ),
          );
        });
  }

  static Widget _getButton({
    required VoidCallback onTap,
    required Color color,
    required String text,
  }) {
    return SizedBox(
      height: 60.h,
      child: Column(
        children: [
          Container(
            height: 1.h,
            width: double.maxFinite,
            color: ColorStyles.primaryBlue,
          ),
          const Spacer(),
          Container(
            height: 50.h,
            width: double.maxFinite,
            child: TextButton(
              onPressed: onTap,
              style: TextButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero)),
              child: Center(
                child: Text(
                  text,
                  style: TextStyle(
                    color: color,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w500,
                    fontSize: 18.sp,
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
