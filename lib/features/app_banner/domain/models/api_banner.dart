class ApiBanner {
  final String id;
  final String? url;
  final String? image;
  final String title;
  final String category;
  final bool isExternal;

  ApiBanner({
    required this.id,
    this.url,
    this.image,
    required this.title,
    required this.category,
    required this.isExternal,
  });

  ApiBanner.fromMap(Map<String, dynamic> map)
      : id = map['id'] is String ? map['id'] : '',
        url = _stringHandler(map['url']),
        image = _stringHandler(map['image']),
        category = map['category'] is String ? map['category'] : '',
        title = map['title'] is String ? map['title'] : '',
        isExternal = _isExternalHandler(map['is_external']);

  static String? _stringHandler(dynamic map) {
    if (map is String && map.isNotEmpty) {
      return map;
    }
    return null;
  }

  static bool _isExternalHandler(dynamic map) {
    if (map is String && map == '0') {
      return false;
    }
    return true;
  }
}
