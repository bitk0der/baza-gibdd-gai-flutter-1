import 'dart:async';

import 'package:contentsize_tabbarview/contentsize_tabbarview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_single_banner_widget.dart';

class AutoScrollPageView extends StatefulWidget {
  final List<AppBanner> banners;
  final EdgeInsets padding;
  const AutoScrollPageView({
    super.key,
    required this.banners,
    required this.padding,
  });
  @override
  AutoScrollPageViewState createState() => AutoScrollPageViewState();
}

class AutoScrollPageViewState extends State<AutoScrollPageView>
    with TickerProviderStateMixin {
  late TabController _pageController;
  Timer? _timer;
  int _currentPage = 0;

  final List<Widget> _pages = [];

  @override
  void initState() {
    _pageController = TabController(length: widget.banners.length, vsync: this);
    _pageController.addListener(() {
      if (_pageController.indexIsChanging) setState(() {});
    });
    fillPages();
    super.initState();
    _startAutoScroll();
  }

  fillPages() {
    for (int i = 0; i < widget.banners.length; i++) {
      if (bannerList
          .where(
            (banner) => banner.category.contains(widget.banners[i].category),
          )
          .isNotEmpty) {
        _pages.add(
          AppSingleBannerWidget(
            appBanner: widget.banners[i],
            width: widget.banners.length > 1
                ? 340.w
                : MediaQuery.of(context).size.width - 40.w,
            isVertical: false,
          ),
        );
      }
    }
  }

  void _startAutoScroll() {
    _timer = Timer.periodic(Duration(seconds: 7), (Timer timer) {
      if (_currentPage < _pages.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0; // Возврат к первой странице
      }
      _pageController.animateTo(
        _currentPage,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Column(
        children: [
          ContentSizeTabBarView(controller: _pageController, children: _pages),
          SizedBox(height: 20.h),
          Wrap(
            alignment: WrapAlignment.center,
            spacing: 10,
            children: [
              for (int i = 0; i < _pages.length; i++)
                indicator(_pageController.index == i),
            ],
          ),
        ],
      ),
    );
  }

  Widget indicator(bool isActive) {
    return AnimatedContainer(
      height: 6.h,
      width: 30.w,
      decoration: BoxDecoration(
        color: isActive ? Color(0xff2D6E58) : Colors.black12,
        borderRadius: BorderRadius.circular(100),
      ),
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }
}
