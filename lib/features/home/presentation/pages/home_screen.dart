import 'package:baza_gibdd_gai/core/network/api_path.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_gradient_svg_icon.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/custom_textfield.dart';
import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late TabController tabController;

  late List<TextEditingController> textEditingControllers;
  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);

    textEditingControllers =
        List.generate(2, (index) => TextEditingController());
    super.initState();
  }

  List<String> hints = ['А 777 АА 77', 'Укажите VIN'];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(Assets.images.mainImage.path),
                    fit: BoxFit.cover)),
            child: SafeArea(
                bottom: false,
                child: Column(
                  children: [
                    const SizedBox(height: 45),
                    Text(
                      'Комплексная проверка автомобиля'.toUpperCase(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.sp,
                          fontFamily: 'MTSCompact',
                          height: 1.1,
                          color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Укажите госномер / VIN\nавтомобиля для проверки',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 17.sp,
                          height: 1.2,
                          color: Colors.white.withValues(alpha: 0.8)),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                  ],
                ))),
        Expanded(
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(
                        Assets.images.backgroundImageWithBorders.path),
                    fit: BoxFit.fill)),
            child: Column(
              children: [
                SizedBox(height: 2),
                Expanded(
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16),
                    child: SafeArea(
                      top: false,
                      child: Column(
                        children: [
                          AppCardLayout(
                              gradient: ColorStyles.cardGradient,
                              endAlignment: Alignment.bottomRight,
                              beginAlignment: Alignment.topLeft,
                              child: Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: ColorStyles.backgroundViolet,
                                        border: Border.all(
                                            color: Colors.white
                                                .withValues(alpha: 0.2)),
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    padding: EdgeInsets.all(4),
                                    child: TabBar(
                                      dividerColor: Colors.transparent,
                                      controller: tabController,
                                      indicatorSize: TabBarIndicatorSize.tab,
                                      labelStyle: TextStyles.h3.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      unselectedLabelStyle: TextStyles.h3
                                          .copyWith(color: Colors.white54),
                                      indicator: BoxDecoration(
                                        color: ColorStyles.backgroundViolet,
                                        gradient: LinearGradient(
                                            colors:
                                                ColorStyles.blueTabBarGradient),
                                        borderRadius: BorderRadius.circular(14),
                                      ),
                                      tabs: [
                                        Tab(text: 'Госномер'),
                                        Tab(text: 'VIN / Кузов'),
                                      ],
                                    ),
                                  ),
                                  ContentSizeTabBarView(
                                    controller: tabController,
                                    children: [tabContent(0), tabContent(1)],
                                  ),
                                ],
                              )),
                          SizedBox(height: 14),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Flexible(
                                  child: AppCardLayout(
                                      backgroundImage:
                                          Assets.images.aiHelper.path,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text('ИИ-помощник ГАИ / ПДД',
                                              style: TextStyles.h1.copyWith(
                                                  fontSize: 20.sp,
                                                  color: Colors.white)),
                                          SizedBox(height: 6),
                                          Text(
                                            'Онлайн-\nпомощь 24/7',
                                            style: TextStyles.h3.copyWith(
                                                fontSize: 15.sp,
                                                color: Colors.white),
                                          ),
                                          SizedBox(height: 28),
                                          AppButton(
                                              title: 'Задать вопрос',
                                              backgroundColor:
                                                  ColorStyles.primaryBlue)
                                        ],
                                      )),
                                ),
                                SizedBox(width: 10),
                                Flexible(
                                    child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    gradientCard(true),
                                    gradientCard(false),
                                  ],
                                ))
                              ],
                            ),
                          ),
                          SizedBox(height: 14),
                          AppCardLayout(
                              backgroundImage: Assets.images.carMain.path,
                              width: double.infinity,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Комплексная проверка собственника',
                                    style: TextStyles.h1,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    'Все долговые обязательства\nи судебные ограничения',
                                    style:
                                        TextStyles.h3.copyWith(fontSize: 15.sp),
                                  ),
                                  SizedBox(height: 8),
                                  AppButton(
                                      title: 'Проверить собственника',
                                      onTap: () => context.router
                                          .navigate(FillDataRoute()),
                                      backgroundColor: ColorStyles.primaryBlue)
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget gradientCard(bool isGreenCard) => AppCardLayout(
      onTap: () => context.router.navigate(isGreenCard
          ? AppWebViewPage(
              title: 'Пример отчета', url: ApiPath.reportExampleUrl)
          : FinesRouter()),
      gradient: isGreenCard
          ? ColorStyles.darkGreenGradient
          : ColorStyles.darkOrangeGradient,
      beginAlignment: Alignment.topCenter,
      endAlignment: Alignment.bottomCenter,
      gradientBorder: isGreenCard
          ? ColorStyles.greenBorderGradient
          : ColorStyles.orangeBorderGradient,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            isGreenCard
                ? Assets.icons.documentsSvg.svg()
                : AppGradientSvgIcon(
                    gradient: ColorStyles.orangeIconGradient,
                    icon: Assets.icons.navBarIcons.finesNavBarIcon),
            Assets.icons.twoArrows.svg()
          ]),
          const SizedBox(height: 14),
          Text(
            isGreenCard ? 'Пример отчета' : 'Оплатить штрафы',
            style: TextStyles.h2
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ],
      ));

  Widget tabContent(int index) {
    bool isActive = textEditingControllers[index].text.isNotEmpty;
    return Column(
      children: [
        SizedBox(height: 16),
        CustomTextField(
            hintText: hints[index],
            onChanged: (v) => setState(() {}),
            textAlign: TextAlign.center,
            padding: EdgeInsets.symmetric(vertical: 17.h),
            textStyle:
                TextStyles.h4.copyWith(fontSize: 24.sp, color: Colors.white),
            hintStyle: TextStyles.h3.copyWith(
                fontSize: 24.sp, color: Colors.white.withValues(alpha: 0.5)),
            controller: textEditingControllers[index]),
        SizedBox(height: 16),
        AppButton(
          title: 'Начать проверку',
          backgroundColor:
              !isActive ? ColorStyles.secondaryBlue : ColorStyles.blue,
          titleColor:
              !isActive ? Colors.white.withValues(alpha: 0.5) : Colors.white,
          onTap: !isActive
              ? null
              : () => context.router
                  .navigate(AppWebViewPage(title: 'Результат проверки')),
        )
      ],
    );
  }
}
