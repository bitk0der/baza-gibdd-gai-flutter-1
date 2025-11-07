/* import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/profile/presentation/widgets/title.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/bloc/notification_bloc.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/widgets/notification_widget.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';

@RoutePage()
class BackgroundNotificationsScreen extends StatefulWidget {
  const BackgroundNotificationsScreen({super.key});

  @override
  State<BackgroundNotificationsScreen> createState() =>
      _BackgroundNotificationsScreenState();
}

class _BackgroundNotificationsScreenState
    extends State<BackgroundNotificationsScreen> {
  late LocalNotificationBloc bloc;
  bool switchValue = false;

  @override
  void initState() {
    bloc = GetIt.I<LocalNotificationBloc>();
    bloc.add(GetNotificationFromCache());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomAppBar.getAppBar(
        isNeedImage: true,
        onTapBackButton: () => context.router.maybePop(),
        title: "Уведомления",
        actions: [
          AppCircleButton(
            icon: Assets.icons.deletecredit,
            buttonSize: 44,
            padding: 10,
            iconColor: Colors.white,
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            onTap: () {},
          ),
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCardLayout(
                color: ColorStyles.gray,
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 16,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Push-уведомления',
                      style: TextStyles.h3.copyWith(fontSize: 18.sp),
                    ),
                    CupertinoSwitch(
                      value: switchValue,
                      onChanged: (v) => setState(() => switchValue = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const AppTitle('Уведомления'),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: bloc,
                builder: (c, state) {
                  if (state is NotificationError) {
                    return const Center(
                      child: Text('Ошибка загрузки уведомлений'),
                    );
                  } else if (state is NotificationLoadedSuccessfull) {
                    if (state.messageResponses.isEmpty) {
                      return _getEmptyListPlaceholder();
                    }
                    /*  return Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        NotificationWidget(
                          messageResponse: getMessageResponse(
                              'Lorem ipsum dolor sit amet consectetur. Fringilla id nam in sed faucibus non vulputate eu. Lorem pulvinar nisl et ullamcorper. Nisl integer nam nunc consectetur...',
                              'https://rozetked.me/',
                              'Заголовок уведомления 2'),
                        ),
                        const SizedBox(height: 10),
                        NotificationWidget(
                          messageResponse: getMessageResponse(
                              'Lorem ipsum dolor sit amet consectetur. Fringilla id nam in sed faucibus non vulputate eu. Lorem pulvinar nisl et ullamcorper. Nisl integer nam nunc consectetur...',
                              'https://rozetked.me/',
                              'Заголовок уведомления'),
                        )
                      ],
                    ),
                  ); */

                    return ListView.separated(
                      itemCount: state.messageResponses.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(20),
                      itemBuilder: (context, index) {
                        return NotificationWidget(
                          messageResponse: state.messageResponses[index],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(height: 10),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppCardLayout _getEmptyListPlaceholder() => AppCardLayout(
        color: ColorStyles.gray,
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
        child: Row(
          children: [
            Assets.icons.bellIcon.svg(
              colorFilter: ColorFilter.mode(
                ColorStyles.black.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            Text('Вам еще не приходили уведомления', style: TextStyles.h3),
          ],
        ),
      );
}
 */
