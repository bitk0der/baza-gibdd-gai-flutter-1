import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_search_request%20copy.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/search_request.dart';

class SearchRequestMapper {
  static ApiSearchRequest toApi(SearchRequest request) {
    String geoPoint = '';
    if (request.userPosition != null) {
      geoPoint = '0,0';
    }
    return ApiSearchRequest(
      page: request.page,
      geoPoint: geoPoint,
      geoRadius: request.geoRadius,
      searchText: request.searchText,
    );
  }
}
