import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/core/widgets/app_card_layout.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_web_view.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/favourite_button.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class FavouriteMessageWidget extends StatefulWidget {
  final ResponseMessageModel message;
  const FavouriteMessageWidget({super.key, required this.message});
  @override
  State<FavouriteMessageWidget> createState() => _FavouriteMessageWidgetState();
}

class _FavouriteMessageWidgetState extends State<FavouriteMessageWidget> {
  @override
  Widget build(BuildContext context) {
    return AppCardLayout(
      color: ColorStyles.primaryBlue,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (!widget.message.isUserMessage)
                      Assets.images.mockConsultantAvatar.image(
                        width: 40.w,
                        height: 40.w,
                      ),
                    Flexible(
                      child: Container(
                        margin: EdgeInsets.only(left: 10.w),
                        padding: EdgeInsets.all(14.w),
                        decoration: BoxDecoration(
                          color: ColorStyles.primaryBlue,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: IntrinsicWidth(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Анастасия',
                                style: TextStyles.h5.copyWith(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: 4),
                              HtmlWidget(
                                widget.message.message,
                                onTapUrl: (url) => launchUrl(
                                  Uri.parse(url),
                                  mode: LaunchMode.externalApplication,
                                ),
                                textStyle: TextStyles.h2.copyWith(
                                  fontSize: 16.sp,
                                  height: 1.1,
                                  fontWeight: FontWeight.w400,
                                  color: !widget.message.isUserMessage
                                      ? Colors.white
                                      : Colors.white,
                                ),
                              ),
                              Column(
                                children: [
                                  SizedBox(height: 6.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        DateFormat.Hm().format(
                                          DateTime.fromMillisecondsSinceEpoch(
                                            widget.message.time,
                                          ),
                                        ),
                                        style: TextStyles.h2.copyWith(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ],
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
              ),
            ],
          ),
          if (widget.message.buttons.isNotEmpty)
            Padding(
              padding: EdgeInsets.only(right: 20.w, left: 50.w, top: 6.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    spacing: 8,
                    runSpacing: 10,
                    children: [
                      for (var i = 0; i < widget.message.buttons.length; i++)
                        buttonWidget(widget.message.buttons[i], i % 2 == 0),
                    ],
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          AppCardLayout(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('dd.MM.yyyy, HH:mm').format(
                    DateTime.fromMillisecondsSinceEpoch(widget.message.time),
                  ),
                  style: TextStyles.h3.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Colors.black45,
                  ),
                ),
                FavouriteButton(message: widget.message),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void onUrlTap(ButtonModel button) {
    if (button.type == 'internal') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => AppWebView(url: button.link, title: button.text),
        ),
      );
    } else {
      launchUrl(Uri.parse(button.link), mode: LaunchMode.externalApplication);
    }
  }

  Widget buttonWidget(ButtonModel button, bool isChet) {
    return InkWell(
      onTap: () => onUrlTap(button),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: isChet ? ColorStyles.primaryBlue : ColorStyles.secondaryBlue,
          boxShadow: [
            BoxShadow(
              color: ColorStyles.white.withValues(alpha: 0.4),
              blurRadius: 20,
            ),
          ],
          borderRadius: BorderRadius.circular(14),
        ),
        child: Text(
          button.text,
          style: TextStyles.h2.copyWith(
            color: ColorStyles.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
