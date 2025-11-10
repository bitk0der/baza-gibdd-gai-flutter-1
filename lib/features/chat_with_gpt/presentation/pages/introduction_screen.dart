import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/routes/app_router.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_gradient_svg_icon.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  List<int> indexes = [0, 1, 3];
  Future<void> _finishOnboarding([
    int? index,
    bool isPushRegister = false,
  ]) async {
    final prefs = GetIt.I<SharedPreferences>();
    await prefs.setBool('first_launch', false);
    if (mounted && !isPushRegister) {
      await context.router.navigate(const PaymentsRoute());
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(Assets.images.chatIntroducingScreen.path))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar.getAppBar(
            title: 'Помощник',
            isBackButton: false,
            isTitleCenter: true,
            isNeedImage: false),
        body: PageView.builder(
          controller: _controller,
          itemCount: 1,
          itemBuilder: (context, index) {
            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                      ).copyWith(top: 20),
                      child: SafeArea(
                        top: false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 60.w,
                              height: 60.w,
                              child: AppGradientSvgIcon(
                                  gradient: ColorStyles.blueIconGradient,
                                  icon:
                                      Assets.icons.navBarIcons.chatNavBarIcon),
                            ),
                            const SizedBox(height: 20),
                            if (pages[index]['title']!.split('/s/').length == 1)
                              Text(
                                pages[index]['title'].toString().toUpperCase(),
                                style: TextStyles.h1.copyWith(
                                    fontSize: 36.sp,
                                    height: 1.2,
                                    fontFamily: 'Oswald'),
                              ),
                            /*   ), */
                            if (pages[index]['title']!.split('/s/').length > 1)
                              RichText(
                                text: TextSpan(
                                  text:
                                      pages[index]['title']!.split('/s/').first,
                                  style: TextStyles.h2.copyWith(
                                    fontFamily: 'Exo2',
                                    fontSize: 30.sp,
                                    height: 1.1,
                                    color: index == 0
                                        ? ColorStyles.blue
                                        : ColorStyles.white,
                                  ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: pages[index]['title']!
                                          .split('/s/')
                                          .last,
                                      style: TextStyle(
                                        color: index != 0
                                            ? ColorStyles.blue
                                            : ColorStyles.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            const SizedBox(height: 12),
                            Text(
                              pages[index]['subtitle']!,
                              textAlign: TextAlign.start,
                              style: TextStyles.h2.copyWith(
                                color: Colors.white.withValues(alpha: 0.8),
                                fontWeight: FontWeight.w400,
                                height: 1.2,
                                fontSize: 18.sp,
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: [
                                Flexible(
                                  child: AppButton(
                                    backgroundColor: ColorStyles.blue,
                                    height: 50,
                                    title: pages[index]['button']!,
                                    onTap: () async {
                                      await _finishOnboarding(null, true);
                                      context.router.navigate(
                                        const HomeChatRoute(),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
