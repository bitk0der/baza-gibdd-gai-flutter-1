import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ButtonRounded extends StatelessWidget {
  final SvgGenImage icon;
  final Color? color;
  final int quarterTurns;
  const ButtonRounded({
    required this.color,
    required this.icon,
    super.key,
    this.quarterTurns = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: RotatedBox(
        quarterTurns: quarterTurns,
        child: icon.svg(
          colorFilter:
              color != null ? ColorFilter.mode(color!, BlendMode.srcIn) : null,
        ),
      ),
    );
  }
}
