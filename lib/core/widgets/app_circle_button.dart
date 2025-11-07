import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

class AppCircleButton extends StatefulWidget {
  final VoidCallback? onTap;
  final Color backgroundColor;
  final SvgGenImage icon;
  final double padding;
  final Color? borderColor;
  final Color? iconColor;
  final double radius;
  final double buttonSize;
  final int quarterTurns;
  final bool isNeedShadow;
  final Widget? customChild;
  final EdgeInsets? customEdgeInsets;

  const AppCircleButton({
    super.key,
    this.onTap,
    this.radius = 12,
    this.backgroundColor = ColorStyles.white,
    required this.icon,
    this.padding = 9,
    this.borderColor,
    this.buttonSize = 36,
    this.quarterTurns = 0,
    this.isNeedShadow = false,
    this.iconColor,
    this.customChild,
    this.customEdgeInsets,
  });

  @override
  State<AppCircleButton> createState() => _AppCircleButtonState();
}

class _AppCircleButtonState extends State<AppCircleButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      borderRadius: BorderRadius.circular(widget.radius),
      child: Container(
        height: widget.buttonSize.w,
        width: widget.buttonSize.w,
        padding: widget.customEdgeInsets ?? EdgeInsets.all(widget.padding.w),
        decoration: BoxDecoration(
          shape: widget.radius == 100 ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: widget.radius == 100
              ? null
              : BorderRadius.circular(widget.radius),
          color: widget.backgroundColor,
          boxShadow: widget.isNeedShadow
              ? [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 10,
                  ),
                ]
              : null,
          border: widget.borderColor == null
              ? null
              : Border.all(color: widget.borderColor!),
        ),
        child: widget.customChild ??
            RotatedBox(
              quarterTurns: widget.quarterTurns,
              child: widget.icon.svg(
                colorFilter: widget.iconColor == null
                    ? null
                    : ColorFilter.mode(widget.iconColor!, BlendMode.srcIn),
              ),
            ),
      ),
    );
  }
}
