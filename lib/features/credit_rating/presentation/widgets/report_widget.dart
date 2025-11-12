import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/report_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportWidget extends StatelessWidget {
  final UserReport report;
  const ReportWidget({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    var map = report.toJson();
    return AppCardLayout(
      radius: 12,
      padding: EdgeInsets.all(14.w),
      gradient: ColorStyles.cardGradient,
      beginAlignment: Alignment.topRight,
      endAlignment: Alignment.bottomLeft,
      isNeedShadow: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _formatDate(report.reportDate),
                style: TextStyles.h4.copyWith(
                  fontSize: 14.sp,
                  color: Colors.white.withValues(alpha: 0.7),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Text(
            report.fullName.toUpperCase(),
            style: TextStyles.h1
                .copyWith(fontSize: 24.sp, height: 1.2, fontFamily: 'Oswald'),
          ),
          SizedBox(height: 8.h),
          Text(
            report.region,
            style: TextStyles.h4.copyWith(
              fontSize: 14.sp,
              height: 1.1,
              color: Colors.white.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 10.h),
          ...map.entries.map(
            (entry) => fieldLabels[entry.key] == null
                ? SizedBox.shrink()
                : _buildInfoRow(fieldLabels[entry.key]!, entry.value),
          ),
          SizedBox(height: 4),
          Row(
            children: [
              Flexible(
                child: AppCardLayout(
                  padding: EdgeInsets.all(15),
                  color: report.status == 'Сформирован'
                      ? Color(0xff1A4246)
                      : Color(0xff424123),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      report.status == 'Сформирован'
                          ? Assets.icons.greenVerified
                              .svg(color: Color(0xff45DAFF))
                          : Assets.icons.clock.svg(),
                      SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          report.status,
                          textAlign: TextAlign.center,
                          style: TextStyles.h3.copyWith(
                            fontSize: 16.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (report.downloadLinks.isNotEmpty &&
                  report.downloadLinks.first.url.isNotEmpty) ...[
                SizedBox(width: 10),
                Flexible(
                  child: AppButton(
                    borderRadius: 16,
                    onTap: () => launchUrl(
                      Uri.parse(report.downloadLinks.first.url),
                      mode: LaunchMode.externalApplication,
                    ),
                    backgroundColor: Color(0xffEE3F58),
                    title: report.downloadLinks.first.title,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return DateFormat("dd.MM.yyyy, HH:mm").format(date);
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: AppCardLayout(
        padding: const EdgeInsets.all(12),
        color: ColorStyles.fillColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyles.h4.copyWith(
                fontSize: 14.sp,
                color: Colors.white.withValues(alpha: 0.6),
              ),
            ),
            Text(value, style: TextStyles.h4.copyWith(fontSize: 17.sp)),
          ],
        ),
      ),
    );
  }
}
