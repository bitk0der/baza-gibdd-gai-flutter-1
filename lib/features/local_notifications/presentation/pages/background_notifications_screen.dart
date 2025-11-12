import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_custom_scaffold.dart';
import 'package:baza_gibdd_gai/core/widgets/custom_app_bar.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/widgets/mock_notification_wodget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/features/local_notifications/presentation/bloc/notification_bloc.dart';

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
    return AppCustomScaffold(
      appBar: CustomAppBar.getAppBar(
          onTapBackButton: () => context.router.maybePop(),
          title: "Ваши подписки",
          isTitleCenter: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppCardLayout(
                color: ColorStyles.fillColor,
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 14,
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
                      inactiveTrackColor:
                          Color(0xff787880).withValues(alpha: 0.25),
                      onChanged: (v) => setState(() => switchValue = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text('Ваши подписки'.toUpperCase(),
                        style: TextStyles.h2
                            .copyWith(fontFamily: 'Oswald', fontSize: 24.sp)),
                  ),
                  Text('Очистить',
                      style: TextStyles.h4.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.white60)),
                ],
              ),
              const SizedBox(height: 16),
              BlocBuilder(
                bloc: bloc,
                builder: (c, state) {
                  if (state is NotificationError) {
                    return const Center(
                      child: Text('Ошибка загрузки уведомлений'),
                    );
                  } else if (state is NotificationLoadedSuccessfull) {
                    return Column(
                      children: [
                        MockNotificationWodget(title: 'СТС:'),
                        SizedBox(height: 12),
                        MockNotificationWodget(title: 'Паспорт:'),
                        SizedBox(height: 12),
                        MockNotificationWodget(title: 'Водителькое:')
                      ],
                    );
                    /*  if (state.messageResponses.isEmpty) {
                      return _getEmptyListPlaceholder();
                    } */
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

                    /* return ListView.separated(
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
                    ); */
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

/*   AppCardLayout _getEmptyListPlaceholder() => AppCardLayout(
        color: ColorStyles.blueCardColor,
        padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 16),
        child: Row(
          children: [
            Assets.icons.bell.svg(
              colorFilter: ColorFilter.mode(
                ColorStyles.black.withValues(alpha: 0.5),
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 10),
            Text('Вам еще не приходили уведомления', style: TextStyles.h3),
          ],
        ),
      ); */
}
