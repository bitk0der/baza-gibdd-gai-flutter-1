import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';
import 'package:baza_gibdd_gai/features/app_banner/domain/models/app_banner.dart';

class BannerUtil {
  static bool shouldRepeat(
    int index, {
    int startIndex = 1,
    int repeatInterval = 4,
  }) {
    // Calculate the zero-based index considering the starting index
    int zeroBasedIndex = index - startIndex;

    // Check if the zero-based index is non-negative and is a multiple of the repeat interval
    return zeroBasedIndex >= 0 && zeroBasedIndex % repeatInterval == 0;
  }

  static Map<String, dynamic> sanitizeString(String input) {
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

  static List<AppBanner> getBannersOnPosition(
    int index,
    String category, [
    bool additionalExpression = true,
  ]) {
    List<AppBanner> shouldRepeatV = [];
    var tmpCategory = category;
    for (var i = 0; i < bannerList.length; i++) {
      var tmpCat = BannerUtil.sanitizeString(bannerList[i].category);
      // return element.category == widget.category;
      if (tmpCat['sanitizedString'] == tmpCategory) {
        if (tmpCat['index'] != null &&
            tmpCat['repeat'] != null &&
            BannerUtil.shouldRepeat(
              index,
              startIndex: tmpCat['index'],
              repeatInterval: tmpCat['repeat'],
            ) &&
            additionalExpression) {
          shouldRepeatV.add(bannerList[i]);
          continue;
        }
      }
      continue;
    }
    return shouldRepeatV;
  }
}
