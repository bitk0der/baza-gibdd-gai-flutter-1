import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/style/chat_ui_util.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

class CustomTextField extends StatefulWidget {
  final String title;
  final String hintText;
  final bool isNeedSuffixIcon;
  final Widget? prefixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextEditingController controller;
  final String? error;
  final int? maxLength;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitteed;
  final String? Function(String?)? validator;
  final Color? errorTextColor;

  const CustomTextField(
      {super.key,
      required this.title,
      required this.hintText,
      required this.controller,
      this.isNeedSuffixIcon = true,
      this.prefixIcon,
      this.keyboardType = TextInputType.number,
      this.inputFormatters,
      this.maxLength,
      this.onTap,
      this.validator,
      this.error,
      this.errorTextColor,
      this.onFieldSubmitteed});

  @override
  State<CustomTextField> createState() => _CustomTextFieldScreenState();
}

class _CustomTextFieldScreenState extends State<CustomTextField> {
  String? localError;

  @override
  void initState() {
    localError = widget.error;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.validator == null) {
      localError = widget.error;
    }

    return AppCardLayout(
      color: Colors.white,
      border: localError != null
          ? Border.all(color: ColorStyles.invoiceStatusRed, width: 1)
          : Border.all(color: Colors.transparent, width: 1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            widget.title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.sp,
              color: ColorStyles.black,
            ),
          ),
          SizedBox(height: 5.h),
          GestureDetector(
            onTap: widget.onTap,
            child: Theme(
              data: ThemeData(primaryColor: ColorStyles.primaryBlue),
              child: TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: widget.validator != null
                    ? (value) {
                        localError = widget.validator!(value);
                        return localError;
                      }
                    : null,
                enabled: widget.onTap == null,
                controller: widget.controller,
                keyboardType: widget.keyboardType,
                onEditingComplete: () {
                  FocusScope.of(context).unfocus();
                },
                inputFormatters: widget.inputFormatters ??
                    [
                      FilteringTextInputFormatter.digitsOnly,
                      UpperCaseTextFormatter(),
                    ],
                style: TextStyle(
                  fontFamily: "PTSans",
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: ColorStyles.primaryBlue,
                ),
                maxLength: widget.maxLength,
                cursorColor: ColorStyles.invoiceStatusRed,
                onFieldSubmitted: widget.onFieldSubmitteed,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(13.w),
                  errorText: widget.error,
                  counterText: "",
                  /*  suffixIcon: isNeedSuffixIcon
                      ? InkWell(
                          onTap: () {
                            AppDialog.showSuccessDialog(context,
                                text: title, image: getImageForHint());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 14),
                            child: Assets.icons.blueHint.svg(),
                          ))
                      : null, */
                  /* prefixIcon: prefix(), */
                  fillColor: ColorStyles.fillColor,
                  filled: true,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ), //textFieldBorderColor
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: ColorStyles.blue,
                    ), //textFieldBorderColor
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                    ), //textFieldBorderColor
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorStyle: TextStyle(
                      color:
                          widget.errorTextColor ?? ColorStyles.invoiceStatusRed,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    fontFamily: "PTSans",
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: ColorStyles.primaryBlue,
                  ),
                ),
              ),
            ),
          ),
          if (widget.isNeedSuffixIcon) ...[
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                getImageForHint().image(width: 230, height: 82),
              ],
            )
          ]
        ],
      ),
    );
  }

  Widget? prefix() {
    if (widget.prefixIcon != null) return widget.prefixIcon!;
    if (!ifTitleContainsOneOfWords() && !ifTitleContainsOneOfTransportWords()) {
      return null;
    }
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: ifTitleContainsOneOfWords()
            ? Assets.icons.personIcon.svg()
            : Assets.icons.carIcon.svg());
  }

  bool ifTitleContainsOneOfWords() {
    return widget.title.toLowerCase().contains('имя') ||
        widget.title.toLowerCase().contains('фамилия') ||
        widget.title.toLowerCase().contains('серия') ||
        widget.title.toLowerCase().contains('отчество') ||
        widget.title.toLowerCase().contains('инн') ||
        widget.title.toLowerCase().contains('паспорт') ||
        widget.title.toLowerCase().contains('снилс') ||
        widget.title.toLowerCase().contains('лицевой') ||
        widget.title.toLowerCase().contains('идентификатор');
  }

  bool ifTitleContainsOneOfTransportWords() {
    return widget.title.toLowerCase().contains('стс') ||
        widget.title.toLowerCase().contains('удостоверение');
  }

  AssetGenImage getImageForHint() {
    switch (true) {
      case var _ when widget.title.toLowerCase().contains("паспорт"):
        return Assets.images.hints.passportHint;
      case var _ when widget.title.toLowerCase().contains("инн"):
        return Assets.images.hints.innHint;
      case var _ when widget.title.toLowerCase().contains("снилс"):
        return Assets.images.hints.snilsHint;
      case var _ when widget.title.toLowerCase().contains("стс"):
        return Assets.images.hints.stsHint;
      case var _ when widget.title.toLowerCase().contains("удостоверение"):
        return Assets.images.hints.vuHint;
      default:
        return Assets.images.hints.passportHint;
    }
  }
}
