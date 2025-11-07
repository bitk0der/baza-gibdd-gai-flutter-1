class Fsin {
  final String id;
  final String url;
  final String fullName;
  final String region;

  Fsin({
    required this.id,
    required this.url,
    required this.fullName,
    required this.region,
  });

  Fsin.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        url = map['url'],
        fullName = map['fullName'],
        region = map['region'];
}
