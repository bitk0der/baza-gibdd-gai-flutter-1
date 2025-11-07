import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_universal_banner_widget.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/pages/fine/fine_payment_screen.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/pages/payment_history_screen/payment_history_screen.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/hexagon.dart';
import 'package:baza_gibdd_gai/features/payments/presentation/widgets/notifications_counter.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<PaymentsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.white,
      body: _getBody(),
    );
  }

  Widget _getBody() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        SafeArea(
          child: Container(
            width: double.maxFinite,
            height: double.maxFinite,
            padding: EdgeInsets.all(20.w),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              color: ColorStyles.primaryBlue,
            ),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Поиск и оплата', style: TextStyles.h2),
                  SizedBox(height: 20.h),
                  _getButton(
                    icon: Assets.icons.navBarIcons.chatNavBarIcon,
                    title: "Штрафы и пошлины ГИБДД",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FinePaymentScreen(),
                        ),
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20.h),
                    child: Text('Сервис', style: TextStyles.h2),
                  ),
                  _getButton(
                    icon: Assets.icons.navBarIcons.chatNavBarIcon,
                    title: "История покупок",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => const PaymentHistoryScreen()),
                      );
                    },
                  ),
                  if (enablePayment)
                    Container(
                      margin: EdgeInsets.only(bottom: 10.h),
                      height: 65.h,
                      width: double.maxFinite,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14)),
                          padding: EdgeInsets.symmetric(
                              horizontal: 14.w, vertical: 12.h),
                        ),
                        onPressed: () {
                          /* Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NotificationsScreen(),
                            ),
                          ); */
                        },
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Hexagon(
                                width: 40.w,
                                height: 44.h,
                                child: Assets.icons.navBarIcons.chatNavBarIcon
                                    .svg()),
                            SizedBox(width: 14.w),
                            Expanded(
                              child: Row(
                                children: [
                                  Text("Уведомления", style: TextStyles.h2),
                                  SizedBox(width: 10.w),
                                  NotificationsCounter(
                                    height: 23.w,
                                    width: 23.w,
                                    fontSize: 12.sp,
                                    color: ColorStyles.black,
                                  ),
                                  const Spacer(),
                                  Container(
                                    padding: EdgeInsets.all(7.5.w),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: ColorStyles.black
                                            .withOpacity(0.05)),
                                    child: Icon(
                                      CupertinoIcons.right_chevron,
                                      color: ColorStyles.black.withOpacity(0.4),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
        AppUniversalBannerWidget(
            padding: EdgeInsets.only(top: 10.h),
            category: 'p-screen-bottom',
            banners: bannerList),
      ],
    );
  }

  Widget _getButton({
    required SvgGenImage icon,
    required String title,
    String? url,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.h),
      width: double.maxFinite,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        ),
        onPressed: onTap ??
            () {
              launchUrl(
                Uri.parse(url!),
                mode: LaunchMode.externalApplication,
              );
            },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Hexagon(width: 40.w, height: 44.h, child: icon.svg()),
            SizedBox(width: 14.w),
            Flexible(
              child: Row(
                children: [
                  Flexible(
                    child: Text(title, style: TextStyles.h2),
                  ),
                  Container(
                    padding: EdgeInsets.all(7.5.w),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorStyles.black.withOpacity(0.05)),
                    child: Icon(
                      CupertinoIcons.right_chevron,
                      color: ColorStyles.black.withOpacity(0.4),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
