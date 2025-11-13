import 'dart:async';
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
  int _dotIndex = 0;

  @override
  void initState() {
    super.initState();
    if (widget.isLoading) _startLoadingTimer();
  }

  void _startLoadingTimer() {
    _timer?.cancel();
    _dotIndex = 0;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() => _dotIndex = (_dotIndex + 1) % 3);
    });
  }

  @override
  void didUpdateWidget(covariant MessageWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !oldWidget.isLoading) {
      _startLoadingTimer();
    } else if (!widget.isLoading && oldWidget.isLoading) {
      _timer?.cancel();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isUser = widget.message.isUserMessage;
    return Container(
      padding: !isUser ? EdgeInsets.all(20.w) : null,
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          _buildMessageRow(isUser),
          _buildButtonsSection(),
        ],
      ),
    );
  }

  Widget _buildMessageRow(bool isUser) {
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Flexible(
          child: Row(
            crossAxisAlignment: widget.isLoading
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isUser) _buildAvatar(),
              _buildMessageBubble(isUser),
            ],
          ),
        ),
        /*  if (!widget.message.isUserMessage &&
            widget.isNeedFavouriteButton &&
            !widget.isLoading)
          FavouriteButton(message: widget.message), */
      ],
    );
  }

  Widget _buildAvatar() {
    return Assets.images.mockConsultantAvatar.image(width: 40.w, height: 40.w);
  }

  Widget _buildMessageBubble(bool isUser) {
    return Container(
      constraints: BoxConstraints(maxWidth: widget.isLoading ? 72.w : 270.w),
      margin:
          isUser ? EdgeInsets.only(right: 20.w) : EdgeInsets.only(left: 10.w),
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color:
            isUser ? ColorStyles.lightBlueCardColor : ColorStyles.blueCardColor,
        borderRadius: BorderRadius.circular(14),
      ),
      child: IntrinsicWidth(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.isLoading
                ? _loadingDots(_dotIndex)
                : isUser
                    ? _buildUserMessage()
                    : _buildHtmlMessage(),
            if (!widget.isLoading) _buildMessageTime(isUser),
          ],
        ),
      ),
    );
  }

  Widget _buildUserMessage() {
    return Text(
      widget.message.message,
      textAlign: TextAlign.left,
      style: TextStyles.h3.copyWith(fontSize: 16.sp, color: Colors.black),
    );
  }

  Widget _buildHtmlMessage() {
    return HtmlWidget(
      widget.message.message,
      onTapUrl: (url) => launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      ),
      textStyle: TextStyles.h2.copyWith(
        fontSize: 16.sp,
        height: 1.1,
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMessageTime(bool isUser) {
    final time = DateFormat.Hm()
        .format(DateTime.fromMillisecondsSinceEpoch(widget.message.time));
    return Padding(
      padding: EdgeInsets.only(top: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            time,
            style: TextStyles.h2.copyWith(
              color: isUser
                  ? Colors.black.withValues(alpha: 0.4)
                  : Colors.white.withValues(alpha: 0.8),
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtonsSection() {
    return Padding(
      padding: EdgeInsets.only(right: 20.w, left: 50.w, top: 6.w),
      child: Wrap(
        spacing: 8,
        runSpacing: 10,
        children: List.generate(
          widget.message.buttons.length,
          (i) => _buildButtonWidget(widget.message.buttons[i], i.isEven),
        ),
      ),
    );
  }

  Widget _buildButtonWidget(ButtonModel button, bool isPrimary) {
    return InkWell(
      onTap: () => _onUrlTap(button),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 13.h),
        decoration: BoxDecoration(
          color: isPrimary ? ColorStyles.blue : ColorStyles.lightBlueCardColor,
          boxShadow: [
            BoxShadow(
              color: ColorStyles.white.withOpacity(0.4),
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

  void _onUrlTap(ButtonModel button) {
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

  Widget _loadingDots(int activeIndex) {
    return SizedBox(
      height: 20.h,
      width: 72.w,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemCount: 3,
        itemBuilder: (_, index) => _dot(index == activeIndex),
        separatorBuilder: (_, __) => SizedBox(width: 6.w),
      ),
    );
  }

  Widget _dot(bool isActive) {
    return Container(
      width: 9.w,
      height: 9.w,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Colors.white.withOpacity(0.2),
        shape: BoxShape.circle,
      ),
    );
  }
}
