import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class MockNotificationWodget extends StatefulWidget {
  final String title;
  const MockNotificationWodget({super.key, required this.title});

  @override
  State<MockNotificationWodget> createState() => _MockNotificationWodgetState();
}

class _MockNotificationWodgetState extends State<MockNotificationWodget> {
  @override
  Widget build(BuildContext context) {
    return AppCardLayout(
      color: Color(0xff1C1A2C),
      child: Row(
        children: [
          Flexible(
            child: AppCardLayout(
                color: Color(0xff2C354B),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: TextStyles.h2.copyWith(
                          color: Colors.white.withValues(alpha: 0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      '9930 742883',
                      style:
                          TextStyles.h2.copyWith(fontWeight: FontWeight.w400),
                    )
                  ],
                )),
          ),
          SizedBox(width: 10),
          AppCircleButton(
            buttonSize: 38,
            padding: 9,
            backgroundColor: Colors.white10,
            icon: Assets.icons.trash,
            onTap: () => {},
          )
        ],
      ),
    );
  }
}
