import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/network/api_path.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/core/widgets/check_tile.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

@RoutePage()
class CreditRatingMainPage extends StatefulWidget {
  const CreditRatingMainPage({super.key});

  @override
  State<CreditRatingMainPage> createState() => _CreditRatingMainPageState();
}

class _CreditRatingMainPageState extends State<CreditRatingMainPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorStyles.fillColor,
      appBar: CustomAppBar.getAppBar(
        title: 'Проверка собственника',
        isTitleCenter: true,
        isNeedImage: true,
        isBackButton: false,
        onTapBackButton: () => context.maybePop(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: AppButton(
              backgroundColor: ColorStyles.blue,
              onTap: () => context.router.navigate(CreditRatingMainOldRoute()),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Assets.icons.search.svg(),
                  SizedBox(width: 10.w),
                  Text(
                    'Начать проверку',
                    style: TextStyles.h1.copyWith(
                      fontSize: 17.sp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 100.h),
        ],
      ),
      body: SafeArea(child: _body()),
    );
  }

  SingleChildScrollView _body() => SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Assets.images.checkOwner.image(),
            SizedBox(height: 16.h),
            Text(
              'Продавец скрывает долги? Узнай до сделки, а не после',
              style: TextStyles.h2.copyWith(fontSize: 30.sp, height: 1.1),
            ),
            SizedBox(height: 12.h),
            Text(
              'Расскажем все о собственнике! Полный отчет о кредитном рейтинге, долговых обязательствах и судебных ограничениях.',
              style: TextStyles.h4.copyWith(
                color: ColorStyles.black.withValues(alpha: 0.9),
                fontSize: 18,
              ),
            ),
            SizedBox(height: 12.h),
            Row(
              children: [
                Flexible(
                  child: CheckTile(
                    icon: Assets.icons.verifiedShield,
                    title:
                        'Личные данные не разглашаются  и не передаются третьим лицам',
                    customIcon: Assets.icons.verifiedShield.svg(),
                  ),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: CheckTile(
                    icon: Assets.icons.russianSymbol,
                    title: '20+ государственных и коммерческих баз данных',
                    customIcon: Assets.icons.russianSymbol.svg(),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            AppCardLayout(
              onTap: () => launchUrl(
                Uri.parse(ApiPath.reportExampleUrl),
                mode: LaunchMode.externalApplication,
              ),
              child: Row(
                children: [
                  Flexible(
                    child: Row(
                      children: [
                        AppCircleButton(
                          icon: Assets.icons.documentsSvg,
                          radius: 100,
                          buttonSize: 36,
                          padding: 8,
                          backgroundColor: ColorStyles.blue,
                          iconColor: Colors.white,
                        ),
                        SizedBox(width: 12.w),
                        Flexible(
                          child: Text(
                            'Посмотреть пример отчета',
                            style: TextStyles.h2.copyWith(
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppCircleButton(
                    icon: Assets.icons.arrowRight,
                    radius: 8,
                    buttonSize: 36,
                    quarterTurns: 2,
                    padding: 8,
                    backgroundColor: ColorStyles.fillColor,
                    iconColor: Colors.black54,
                  ),
                ],
              ),
            ),
            SizedBox(height: 60.h),
          ],
        ),
      );
}
