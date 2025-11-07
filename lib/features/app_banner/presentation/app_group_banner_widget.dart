import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';
import 'package:baza_gibdd_gai/features/app_banner/presentation/banner_click_handler.dart';

class AppGroupBannersWidget extends StatefulWidget {
  final List<AppBanner> banners;
  final String? category;
  final Widget? fallbackWidget;

  const AppGroupBannersWidget(
    this.banners, {
    super.key,
    this.category,
    this.fallbackWidget,
  });

  @override
  State<AppGroupBannersWidget> createState() => _AppGroupBannersWidgetState();
}

class _AppGroupBannersWidgetState extends State<AppGroupBannersWidget> {
  List<AppBanner> _banners = [];

  @override
  void initState() {
    if (widget.category != null) {
      _banners = widget.banners
          .where((element) => element.category == widget.category)
          .toList();
    } else {
      _banners = widget.banners;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.fallbackWidget != null && _banners.isEmpty) {
      return widget.fallbackWidget!;
    }
    return DynamicHeightGridView(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: _banners.isNotEmpty
          ? EdgeInsets.symmetric(vertical: 0.h)
          : EdgeInsets.zero,
      // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //   crossAxisCount: 2,
      //   crossAxisSpacing: 10,
      //   mainAxisSpacing: 10,
      // ),
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      itemCount: _banners.length,
      builder: (context, index) => GestureDetector(
        onTap: () =>
            BannerClickHandler.bannerClickHandler(context, _banners[index]),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: CachedNetworkImage(
            imageUrl: _banners[index].image,
            fit: BoxFit.fill,
            progressIndicatorBuilder: (context, url, downloadProgress) =>
                Container(
              width: double.maxFinite,
              height: 120.h,
              color: Colors.grey,
              child: Center(
                child: CircularProgressIndicator(
                  value: downloadProgress.progress,
                  color: Colors.white,
                ),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              width: double.maxFinite,
              height: 120.h,
              color: Colors.grey,
              child: const Center(child: Icon(Icons.image, size: 36)),
            ),
          ),
        ),
      ),
    );
  }
}

/// GridView with dynamic height
///
/// Usage is almost same as [GridView.count]
class DynamicHeightGridView extends StatelessWidget {
  const DynamicHeightGridView({
    Key? key,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.controller,
    this.shrinkWrap = false,
    this.physics,
    this.padding = EdgeInsets.zero,
  }) : super(key: key);
  final IndexedWidgetBuilder builder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment rowCrossAxisAlignment;

  final ScrollPhysics? physics;
  final ScrollController? controller;
  final bool shrinkWrap;
  final EdgeInsets padding;

  int columnLength() {
    if (itemCount % crossAxisCount == 0) {
      return itemCount ~/ crossAxisCount;
    } else {
      return (itemCount ~/ crossAxisCount) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10.h),
      child: ListView.builder(
        padding: padding,
        controller: controller,
        shrinkWrap: shrinkWrap,
        physics: physics,
        itemBuilder: (ctx, columnIndex) {
          return _GridRow(
            columnIndex: columnIndex,
            builder: builder,
            itemCount: itemCount,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            crossAxisAlignment: rowCrossAxisAlignment,
          );
        },
        itemCount: columnLength(),
      ),
    );
  }
}

/// Use this for [CustomScrollView]
class SliverDynamicHeightGridView extends StatelessWidget {
  const SliverDynamicHeightGridView({
    Key? key,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    this.crossAxisSpacing = 8,
    this.mainAxisSpacing = 8,
    this.rowCrossAxisAlignment = CrossAxisAlignment.start,
    this.controller,
  }) : super(key: key);
  final IndexedWidgetBuilder builder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment rowCrossAxisAlignment;
  final ScrollController? controller;

  int columnLength() {
    if (itemCount % crossAxisCount == 0) {
      return itemCount ~/ crossAxisCount;
    } else {
      return (itemCount ~/ crossAxisCount) + 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate((ctx, columnIndex) {
        return _GridRow(
          columnIndex: columnIndex,
          builder: builder,
          itemCount: itemCount,
          crossAxisCount: crossAxisCount,
          crossAxisSpacing: crossAxisSpacing,
          mainAxisSpacing: mainAxisSpacing,
          crossAxisAlignment: rowCrossAxisAlignment,
        );
      }, childCount: columnLength()),
    );
  }
}

class _GridRow extends StatelessWidget {
  const _GridRow({
    Key? key,
    required this.columnIndex,
    required this.builder,
    required this.itemCount,
    required this.crossAxisCount,
    required this.crossAxisSpacing,
    required this.mainAxisSpacing,
    required this.crossAxisAlignment,
  }) : super(key: key);
  final IndexedWidgetBuilder builder;
  final int itemCount;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final CrossAxisAlignment crossAxisAlignment;
  final int columnIndex;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: (columnIndex == 0) ? 0 : mainAxisSpacing),
      child: Row(
        crossAxisAlignment: crossAxisAlignment,
        children: List.generate((crossAxisCount * 2) - 1, (rowIndex) {
          final rowNum = rowIndex + 1;
          if (rowNum % 2 == 0) {
            return SizedBox(width: crossAxisSpacing);
          }
          final rowItemIndex = ((rowNum + 1) ~/ 2) - 1;
          final itemIndex = (columnIndex * crossAxisCount) + rowItemIndex;
          if (itemIndex > itemCount - 1) {
            return const Expanded(child: SizedBox());
          }
          return Expanded(child: builder(context, itemIndex));
        }),
      ),
    );
  }
}

// // OLD WORKING CODE
// class AppGroupBannersWidget extends StatefulWidget {
//   final List<AppBanner> banners;
//   final String? category;
//   final Widget? fallbackWidget;
//
//   const AppGroupBannersWidget(
//       this.banners, {
//         super.key,
//         this.category,
//         this.fallbackWidget,
//       });
//
//   @override
//   State<AppGroupBannersWidget> createState() => _AppGroupBannersWidgetState();
// }
//
// class _AppGroupBannersWidgetState extends State<AppGroupBannersWidget> {
//   List<AppBanner> _banners = [];
//
//   @override
//   void initState() {
//     if (widget.category != null) {
//       _banners = widget.banners.where((element) => element.category == widget.category).toList();
//     } else {
//       _banners = widget.banners;
//     }
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.fallbackWidget != null && _banners.isEmpty) {
//       return widget.fallbackWidget!;
//     }
//     return GridView.builder(
//       physics: const NeverScrollableScrollPhysics(),
//       shrinkWrap: true,
//       padding: _banners.isNotEmpty ? EdgeInsets.symmetric(vertical: 0.h) : EdgeInsets.zero,
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 10,
//         mainAxisSpacing: 10,
//       ),
//       itemCount: _banners.length,
//       itemBuilder: (context, index) => GestureDetector(
//         onTap: () => BannerClickHandler.bannerClickHandler(context, _banners[index]),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(12),
//           child: CachedNetworkImage(
//             imageUrl: _banners[index].image,
//             fit: BoxFit.fill,
//             progressIndicatorBuilder: (context, url, downloadProgress) => Container(
//               width: double.maxFinite,
//               height: 120.h,
//               color: Colors.grey,
//               child: Center(
//                 child: CircularProgressIndicator(
//                   value: downloadProgress.progress,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             errorWidget: (context, url, error) => Container(
//               width: double.maxFinite,
//               height: 120.h,
//               color: Colors.grey,
//               child: const Center(
//                 child: Icon(Icons.image, size: 36),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
