import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_banner_autoscroll_widget.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_banner_widget.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_group_banner_widget.dart';

import '../domain/models/app_banner.dart';

class AppUniversalBannerWidget extends StatefulWidget {
  final List<AppBanner> banners;
  final String category;
  final EdgeInsets padding;

  const AppUniversalBannerWidget({
    super.key,
    this.banners = const [],
    this.padding = EdgeInsets.zero,
    required this.category,
  });

  @override
  State<AppUniversalBannerWidget> createState() =>
      _AppUniversalBannerWidgetState();
}

class _AppUniversalBannerWidgetState extends State<AppUniversalBannerWidget> {
  final _verticalBanners = <AppBanner>[];
  final _horizontalBanners = <AppBanner>[];
  final _gridBanners = <AppBanner>[];
  final _scrollBanners = <AppBanner>[];
  @override
  void initState() {
    super.initState();
    for (var ban in widget.banners) {
      if (ban.category.endsWith('-vertical')) {
        if (widget.category == ban.category.replaceAll('-vertical', '')) {
          _verticalBanners.add(ban);
        }
      }
      if (ban.category.endsWith('-horizontal')) {
        if (widget.category == ban.category.replaceAll('-horizontal', '')) {
          _horizontalBanners.add(ban);
        }
      }
      if (ban.category.endsWith('-grid')) {
        if (widget.category == ban.category.replaceAll('-grid', '')) {
          _gridBanners.add(ban);
        }
      }
      if (ban.category.endsWith('-scroll')) {
        if (widget.category == ban.category.replaceAll('-scroll', '')) {
          _scrollBanners.add(ban);
        }
      }
    }
  }

  List<T> addConstantBetweenElements<T>(List<T> list, T constantElement) {
    List<T> resultList = [];

    for (int i = 0; i < list.length; i++) {
      resultList.add(list[i]);
      if (i < list.length - 1) {
        // resultList.add(constantElement);
      }
    }

    return resultList;
  }

  @override
  Widget build(BuildContext context) {
    if (_verticalBanners.isEmpty &&
        _horizontalBanners.isEmpty &&
        _gridBanners.isEmpty) {
      return Container();
    }
    if (_scrollBanners.isNotEmpty) {
      return AutoScrollPageView(
        banners: _scrollBanners,
        padding: widget.padding,
      );
    }
    var allBanners = [
      _verticalBanners.isEmpty
          ? null
          : AppBannersWidget(_verticalBanners, isVertical: true),
      _horizontalBanners.isEmpty
          ? null
          : AppBannersWidget(_horizontalBanners, isVertical: false),
      _gridBanners.isEmpty ? null : AppGroupBannersWidget(_gridBanners),
    ].where((el) => el != null).toList();

    List<Widget?> allbannerList = addConstantBetweenElements(
      allBanners,
      const SizedBox(height: 10),
    );

    return Padding(
      padding: widget.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // SizedBox(height: 10,),
          ...List.from(allbannerList),
          // SizedBox(height: 10,),
          // ...[_verticalBanners.isEmpty ? null : AppBannersWidget(_verticalBanners, isVertical: true,),
          // _horizontalBanners.isEmpty ? null : AppBannersWidget(_horizontalBanners, isVertical: false,),
          // _gridBanners.isEmpty ? null : AppGroupBannersWidget(_gridBanners)].where((Widget? el)=>el != null).toList<Widget>(),
        ],
      ),
    );
  }
}
