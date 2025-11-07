import 'api_point.dart';

class ApiSearchResponse{
  static const _TOTAL = "total";
  static const _PAGE = "page";
  static const _TOTAL_PAGES = "totalPages";


  final int total;
  final int page;
  final int totalPages;
  final List<ApiPoint> points;

  ApiSearchResponse.fromMap(Map<String, dynamic> map, {required this.points}):
    total = map[_TOTAL],
    page = map[_PAGE],
    totalPages = map[_TOTAL_PAGES];
}