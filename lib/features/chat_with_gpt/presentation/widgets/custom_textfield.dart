import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController? controller;
  final int? maxLength;
  final EdgeInsets? padding;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitteed;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color? errorTextColor;
  final Color? fillColor;
  final Color? enabledColor;
  final String? errorText;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.suffixIcon,
    this.keyboardType = TextInputType.number,
    this.inputFormatters,
    this.maxLength,
    this.onTap,
    this.validator,
    this.fillColor,
    this.errorTextColor,
    this.onFieldSubmitteed,
    this.onChanged,
    this.padding,
    this.enabledColor,
    this.prefixIcon,
    this.focusNode,
    this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TextFormField(
        key: key,
        validator: validator,
        focusNode: focusNode,
        enabled: onTap == null,
        controller: controller,
        keyboardType: keyboardType,
        onEditingComplete: () {
          FocusScope.of(context).unfocus();
        },
        style: TextStyles.h4.copyWith(fontSize: 16.sp, color: Colors.black),
        maxLength: maxLength,
        cursorColor: ColorStyles.black,
        inputFormatters: inputFormatters,
        onFieldSubmitted: onFieldSubmitteed,
        onChanged: onChanged,
        decoration: InputDecoration(
          contentPadding: padding ?? EdgeInsets.all(14.w),
          counterText: "",
          errorText: errorText,
          suffixIcon: suffixIcon,
          fillColor: fillColor ?? ColorStyles.fillColor,
          filled: true,
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: enabledColor ?? Colors.transparent,
            ), //textFieldBorderColor
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: enabledColor ?? Colors.transparent,
            ), //textFieldBorderColor
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(
              color: ColorStyles.white,
            ), //textFieldBorderColor
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: ColorStyles.black),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorStyle: TextStyle(color: Colors.red),
          hintText: hintText,
          prefixIcon: prefixIcon,
          hintStyle: TextStyles.h4.copyWith(
            color: Colors.black.withValues(alpha: 0.5),
            fontSize: 16.sp,
          ),
        ),
      ),
    );
  }
}
