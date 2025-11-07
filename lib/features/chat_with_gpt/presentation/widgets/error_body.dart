import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/custom_button.dart';

class ErrorBody extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final Color? iconColor;

  const ErrorBody({
    super.key,
    this.textStyle,
    this.iconColor,
    this.text =
        "Произошла ошибка\nНажмите, чтобы вернуться назад и повторить попытку",
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 100,
                color: iconColor ?? ColorStyles.black,
              ),
              SizedBox(height: 5.h),
              Text(
                text,
                textAlign: TextAlign.center,
                style: textStyle ??
                    TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.sp,
                      color: ColorStyles.black,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ErrorPlaceholder extends StatelessWidget {
  const ErrorPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        color: ColorStyles.blue,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Spacer(),
          Align(
            alignment: Alignment.center,
            child: SvgPicture.asset('assets/icons/error.svg', width: 180.w),
          ),
          const Spacer(),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Strings.errorTitle',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: ColorStyles.black,
                fontSize: 26.sp,
              ),
            ),
          ),
          SizedBox(height: 16.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Strings.errorText',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                color: ColorStyles.black.withOpacity(0.7),
                fontSize: 18.sp,
              ),
            ),
          ),
          SizedBox(height: 50.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: CustomButton(
              title: 'Strings.goSearch',
              color: ColorStyles.black,
              height: 50,
              onTap: () => Navigator.pop(context),
            ),
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
