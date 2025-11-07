import 'dart:async';
import 'package:baza_gibdd_gai/features/chat_with_gpt/presentation/widgets/favourite_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:intl/intl.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/core/theme/app_fonts.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_web_view.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:baza_gibdd_gai/gen/assets.gen.dart';
import 'package:url_launcher/url_launcher.dart';

class MessageWidget extends StatefulWidget {
  final bool isLoading;
  final ResponseMessageModel message;
  final bool isNeedFavouriteButton;
  const MessageWidget({
    required this.message,
    this.isLoading = false,
    this.isNeedFavouriteButton = true,
    super.key,
  });

  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  Timer? _timer;
  int _start = 0;

  @override
  void initState() {
    if (widget.isLoading) {
      startTimer();
    }
    super.initState();
  }

  void startTimer() {
    _timer?.cancel();
    _start = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start < 2) {
        _start++;
      } else {
        _start = 0;
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: !widget.message.isUserMessage ? EdgeInsets.all(20.w) : null,
      child: Column(
        crossAxisAlignment: widget.message.isUserMessage
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: widget.message.isUserMessage
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              Flexible(
                child: Row(
                  crossAxisAlignment: widget.isLoading
                      ? CrossAxisAlignment.center
                      : CrossAxisAlignment.start,
                  mainAxisAlignment: widget.message.isUserMessage
                      ? MainAxisAlignment.end
                      : MainAxisAlignment.start,
                  children: [
                    if (!widget.message.isUserMessage)
                      Assets.images.mockConsultantAvatar.image(
                        width: 40.w,
                        height: 40.w,
                      ),
                    Container(
                      constraints: BoxConstraints(
                        maxWidth: widget.isLoading ? 72.w : 270.w,
                      ),
                      margin: widget.message.isUserMessage
                          ? EdgeInsets.only(right: 20.w)
                          : EdgeInsets.only(left: 10.w),
                      padding: EdgeInsets.all(14.w),
                      decoration: BoxDecoration(
                        color: widget.message.isUserMessage
                            ? ColorStyles.primaryBlue
                            : ColorStyles.primaryBlue,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: IntrinsicWidth(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (!widget.message.isUserMessage) ...[
                              Text(
                                'Анастасия',
                                style: TextStyles.h5.copyWith(
                                  fontSize: 12,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                              ),
                              const SizedBox(height: 4),
                            ],
                            widget.isLoading
                                ? loadingDots(_start)
                                : !widget.message.isUserMessage
                                    ? HtmlWidget(
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
                                      )
                                    : Text(
                                        widget.message.message,
                                        textAlign: !widget.message.isUserMessage
                                            ? TextAlign.right
                                            : TextAlign.left,
                                        style: TextStyles.h2.copyWith(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          height: 1.2,
                                        ),
                                      ),
                            if (!widget.isLoading)
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
                                          color: !widget.message.isUserMessage
                                              ? Colors.white.withValues(
                                                  alpha: 0.8,
                                                )
                                              : Colors.black.withValues(
                                                  alpha: 0.4,
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
                  ],
                ),
              ),
              if (!widget.message.isUserMessage &&
                  widget.isNeedFavouriteButton &&
                  !widget.isLoading)
                FavouriteButton(message: widget.message),
            ],
          ),
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

  Widget loadingDots(int index) {
    return SizedBox(
      height: 20.h,
      width: 72.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (_, i) => dot(index == i),
        separatorBuilder: (_, i) => SizedBox(width: 6.w),
        itemCount: 3,
      ),
    );
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

  Widget dot(bool isActive) {
    return Container(
      width: 9.w,
      height: 9.w,
      decoration: BoxDecoration(
        color:
            isActive ? Colors.white : ColorStyles.white.withValues(alpha: 0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
