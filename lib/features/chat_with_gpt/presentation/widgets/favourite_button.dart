import 'package:baza_gibdd_gai/core/constants/constants.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/widgets/app_circle_button.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/utils/chat_worker.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FavouriteButton extends StatefulWidget {
  final ResponseMessageModel message;
  const FavouriteButton({super.key, required this.message});

  @override
  State<FavouriteButton> createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return AnimatedCrossFade(
      firstChild: AppCircleButton(
        icon: Assets.icons.navBarIcons.chatNavBarIcon,
        padding: 5,
        onTap: () async {
          await ChatWorker.removeMessageFromFavourites(widget.message);
          setState(() {});
        },
        iconColor: Colors.orange,
        backgroundColor: ColorStyles.primaryBlue,
      ),
      secondChild: AppCircleButton(
        icon: Assets.icons.navBarIcons.chatNavBarIcon,
        padding: 5,
        onTap: () async {
          await ChatWorker.saveMessageToFavourites(widget.message);
          setState(() {});
        },
        iconColor: Colors.black.withValues(alpha: 0.5),
        backgroundColor: ColorStyles.primaryBlue,
      ),
      crossFadeState: ChatWorker.isInFavourites(widget.message)
          ? CrossFadeState.showFirst
          : CrossFadeState.showSecond,
      duration: standartDuration,
    );
  }
}
