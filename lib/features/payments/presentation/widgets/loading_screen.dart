import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/core/theme/app_colors.dart';
import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_universal_banner_widget.dart';

class LoadingScreen extends StatefulWidget {
  final String? title;

  const LoadingScreen({
    super.key,
    this.title,
  });

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  double _progressValue = 0;

  late Timer _t;

  @override
  void initState() {
    _start();
    super.initState();
  }

  @override
  void dispose() {
    _t.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200.w,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: LinearProgressIndicator(
                backgroundColor: ColorStyles.blue,
                minHeight: 20.h,
                value: _progressValue,
                color: ColorStyles.blue,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Text(
            widget.title ?? "Подождите, идет загрузка...",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontSize: 22.sp,
              color: ColorStyles.primaryBlue,
            ),
          )
        ],
      ),
    );
  }

  void _start() {
    Timer.periodic(const Duration(milliseconds: 20), (Timer t) {
      _t = t;
      setState(() {
        _progressValue += 0.01;
        if (_progressValue > 1.1) {
          _progressValue = 0;
          // t.cancel();
          // return;
        }
      });
    });
  }
}

class LoadingSearchIndicator extends StatelessWidget {
  const LoadingSearchIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
          padding:
              EdgeInsets.only(top: 36.h, bottom: 30.h, left: 16.w, right: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  width: 59.r,
                  height: 59.r,
                  child: CircularProgressIndicator(
                    color: ColorStyles.invoiceStatusRed,
                    backgroundColor:
                        ColorStyles.invoiceStatusRed.withOpacity(0.5),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                'Идет проверка задолженности',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ColorStyles.primaryBlue,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 30.h),
              Text(
                'Осталось:',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.5),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
              const _ShowTimer(),
            ],
          ),
        ),
        const Spacer(),
        AppUniversalBannerWidget(
          category: 's-screen',
          banners: bannerList,
          padding: EdgeInsets.all(20.w),
        )
      ],
    );
  }
}

class _ShowTimer extends StatefulWidget {
  const _ShowTimer();

  @override
  State<_ShowTimer> createState() => _ShowTimerState();
}

class _ShowTimerState extends State<_ShowTimer> {
  int _start = 120;
  late Timer _timer;

  @override
  void initState() {
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _getContainer((_start ~/ 60).toString()),
        Text(
          ':',
          style: TextStyle(
            color: Colors.black,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(width: 6.w),
        _getContainer(((_start % 60) ~/ 10).toString()),
        _getContainer(((_start % 60) % 10).toString()),
      ],
    );
  }

  void _startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  Widget _getContainer(String text) {
    return Container(
      width: 50.r,
      height: 50.r,
      margin: EdgeInsets.only(right: 6.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorStyles.invoiceStatusRed),
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
            color: Colors.black,
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
