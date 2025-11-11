import 'package:auto_route/auto_route.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_button.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';

Future<bool> showModal(BuildContext context) async =>
    await showModalBottomSheet(
        context: context,
        useRootNavigator: true,
        builder: (ctx) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.white),
              child: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                            child: Text(
                          'Вы хотите перезаписать данные?',
                          style: TextStyles.h1,
                        )),
                        AppCircleButton(
                            icon: Assets.icons.closeIcon,
                            backgroundColor: Colors.black12,
                            onTap: () => ctx.maybePop(false))
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Предыдущие данные будут сброшены и заменены на новые. Мониторинг будет производится уже по новым данным',
                      style: TextStyles.h4.copyWith(fontSize: 17),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      title: 'Перезаписать данные',
                      onTap: () => ctx.maybePop(true),
                    ),
                    const SizedBox(height: 14),
                    AppButton(
                      title: 'Отменить',
                      titleColor: Colors.black,
                      backgroundColor: ColorStyles.black.withValues(alpha: 0.1),
                      onTap: () => ctx.maybePop(false),
                    ),
                  ],
                ),
              ),
            ));

addPostFrameCallback(
        VoidCallback callback, BuildContext context, List<String> fields,
        [VoidCallback? whenNegativeCallback]) =>
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (fields.where((e) => e.trim().isNotEmpty).isNotEmpty) {
        await showModalFillData(context).then((value) {
          if (value) {
            callback();
          } else {
            if (whenNegativeCallback != null) whenNegativeCallback();
          }
        });
      }
    });

Future<bool> showModalFillData(BuildContext context) async =>
    await showModalBottomSheet(
        context: context,
        builder: (ctx) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 22),
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                  color: Colors.white),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: Text(
                        'У вас есть заполненные данные в профиле',
                        style: TextStyles.h1,
                      )),
                      AppCircleButton(
                          icon: Assets.icons.closeIcon,
                          backgroundColor: Colors.black12,
                          onTap: () => ctx.maybePop(false))
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Если вы хотите проверить собственные документы, мы можем автоматически заполнить поля из профиля',
                    style: TextStyles.h4.copyWith(fontSize: 17),
                  ),
                  const SizedBox(height: 24),
                  AppButton(
                    title: 'Заполнить данные из профиля',
                    onTap: () => ctx.maybePop(true),
                  ),
                  const SizedBox(height: 14),
                  AppButton(
                    title: 'Заполнить данные вручную',
                    backgroundColor: ColorStyles.orange,
                    onTap: () => ctx.maybePop(false),
                  ),
                ],
              ),
            )) ??
    false;
