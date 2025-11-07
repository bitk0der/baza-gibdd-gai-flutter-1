import 'package:baza_gibdd_gai/features/payments/data/models/user_position.dart';

class SearchRequest {
  final int page;
  final UserPosition? userPosition;
  final int geoRadius;
  final String searchText;

  SearchRequest({
    this.page = 1,
    required this.userPosition,
    this.geoRadius = 0,
    this.searchText = "",
  });

  SearchRequest copyWith({
    String? searchText,
    UserPosition? userPosition,
    int? page,
  }) {
    return SearchRequest(
      page: page ?? this.page,
      userPosition: userPosition ?? this.userPosition,
      geoRadius: this.geoRadius,
      searchText: searchText ?? this.searchText,
    );
  }
}
