class ApiSearchRequest{
  final int page;
  final String geoPoint;
  final int geoRadius;
  final String searchText;

  ApiSearchRequest({
    required this.page,
    required this.geoPoint,
    required this.geoRadius,
    required this.searchText
  });
}