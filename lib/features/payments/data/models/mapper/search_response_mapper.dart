import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_search_response.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/api_models/search_response.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/point.dart';

import 'point_mapper.dart';

class SearchResponseMapper {
  static SearchResponse fromApi(ApiSearchResponse apiSearchResponse) {
    List<Point> points = [];
    for (var element in apiSearchResponse.points) {
      points.add(PointMapper.fromApi(element));
    }
    return SearchResponse(
      total: apiSearchResponse.total,
      totalPages: apiSearchResponse.totalPages,
      page: apiSearchResponse.page,
      points: points,
    );
  }
}
