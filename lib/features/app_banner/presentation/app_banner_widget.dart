import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/app_single_banner_widget.dart';

class AppBannersWidget extends StatefulWidget {
  final List<AppBanner> banners;
  final String? category;
  final bool isVertical;
  final Widget? fallbackWidget;
  final int? currentIndex;

  const AppBannersWidget(
    this.banners, {
    super.key,
    this.category,
    this.isVertical = true,
    this.currentIndex,
    this.fallbackWidget,
  });

  @override
  State<AppBannersWidget> createState() => _AppBannersWidgetState();
}

class _AppBannersWidgetState extends State<AppBannersWidget> {
  List<AppBanner> _banners = [];

  Map<String, dynamic> sanitizeString(String input) {
    try {
      // Regular expressions to find the patterns
      RegExp indexPattern = RegExp(r'index-(\d+)-');
      RegExp repeatPattern = RegExp(r'repeat-(\d+)-');

      // Check if both patterns exist in the string
      Match? indexMatch = indexPattern.firstMatch(input);
      Match? repeatMatch = repeatPattern.firstMatch(input);

      if (indexMatch != null && repeatMatch != null) {
        // Extract the index and repeat numbers
        int index = int.parse(indexMatch.group(1)!);
        int repeat = int.parse(repeatMatch.group(1)!);

        // Remove the patterns from the string
        String sanitizedString = input
            .replaceAll(indexPattern, '')
            .replaceAll(repeatPattern, '')
            .trim();

        return {
          'sanitizedString': sanitizedString,
          'index': index,
          'repeat': repeat,
        };
      } else {
        // Return the original input if patterns not found
        return {'sanitizedString': input, 'index': null, 'repeat': null};
      }
    } catch (e) {
      // Return the original input in case of any error
      return {'sanitizedString': input, 'index': null, 'repeat': null};
    }
  }

  @override
  void initState() {
    if (widget.category != null) {
      _banners = widget.banners.where((element) {
        var tmpCat = sanitizeString(element.category);
        // return element.category == widget.category;
        return tmpCat['sanitizedString'] == widget.category;
      }).toList();
    } else {
      _banners = widget.banners;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_banners.isEmpty && widget.fallbackWidget != null) {
      return widget.fallbackWidget!;
    }
    // if(_banners.isEmpty){
    //   return Container();
    // }
    if (widget.isVertical) {
      return Column(children: _getList());
    }
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(children: _getList()),
    );
  }

  bool shouldRepeat(int index, {int startIndex = 0, int repeatInterval = 4}) {
    // Calculate the zero-based index considering the starting index
    int zeroBasedIndex = index - startIndex;

    // Check if the zero-based index is non-negative and is a multiple of the repeat interval
    return zeroBasedIndex >= 0 && zeroBasedIndex % repeatInterval == 0;
  }

  List<Widget> _getList() {
    return List.generate(_banners.length, (index) {
      // if(widget.currentIndex != null) {
      //   var tmpBan = sanitizeString(_banners[index].category);
      //   if (tmpBan['index'] != null && tmpBan['repeat'] != null) {
      //     var should = shouldRepeat(widget.currentIndex!, startIndex: tmpBan['index'], repeatInterval: tmpBan['repeat']);
      //     if(!should){
      //       return Container();
      //     }
      //   }
      // }
      return AppSingleBannerWidget(
        width: widget.isVertical
            ? double.maxFinite
            : _banners.length > 1
                ? 340.w
                : MediaQuery.of(context).size.width - 40.w,
        isVertical: widget.isVertical,
        appBanner: _banners[index],
      );
    });
  }
}
