import 'dart:convert';

class RegionResponse {
  final bool success;
  final List<Region> regions;

  RegionResponse({required this.success, required this.regions});

  factory RegionResponse.fromJson(Map<String, dynamic> json) {
    return RegionResponse(
      success: json['success'],
      regions:
          (json['regions'] as List).map((e) => Region.fromJson(e)).toList(),
    );
  }

  String toJson() {
    final Map<String, dynamic> json = {
      'success': success,
      'regions': regions.map((e) => e.toJson()).toList(),
    };
    return jsonEncode(json);
  }
}

class Region {
  final int code;
  final String name;

  Region({required this.code, required this.name});

  factory Region.fromJson(Map<String, dynamic> json) {
    return Region(code: json['code'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name};
  }
}
