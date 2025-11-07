import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';

class NewAppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const NewAppbarWidget({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorStyles.blue,
      shadowColor: Colors.transparent,
      toolbarHeight: 85.h,
      leadingWidth: 76.w,
      leading: Builder(
        builder: (context) => InkWell(
          onTap: () => Navigator.pop(context),
          child: Container(
            margin: EdgeInsets.all(16.w),
            constraints: BoxConstraints(maxHeight: 40.h, maxWidth: 40.w),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2), shape: BoxShape.circle),
            child: const Icon(
              CupertinoIcons.left_chevron,
              color: ColorStyles.white,
              size: 20,
            ),
          ),
        ),
      ),
      titleSpacing: 0,
      title: Text(title, style: TextStyles.h2),
    );
  }

  @override
  Size get preferredSize => Size(0, 85.h);
}
