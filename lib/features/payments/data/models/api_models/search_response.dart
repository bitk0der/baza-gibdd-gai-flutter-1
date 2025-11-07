import 'package:baza_gibdd_gai/features/payments/data/models/point.dart';

class SearchResponse {
  final int total;
  final int page;
  final int totalPages;
  final List<Point> points;

  SearchResponse({
    required this.total,
    required this.page,
    required this.totalPages,
    required this.points,
  });

  SearchResponse copyWith({
    List<Point>? points,
  }) {
    return SearchResponse(
      total: this.total,
      page: this.page,
      totalPages: this.totalPages,
      points: points ?? this.points,
    );
  }
}
