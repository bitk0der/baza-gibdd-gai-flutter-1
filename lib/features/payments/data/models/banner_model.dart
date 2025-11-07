class BannerModel {
  final String image;
  final String? url;
  final bool isWebView;

  BannerModel({
    required this.image,
    required this.url,
    this.isWebView = false,
  });

  BannerModel.fromMap(Map<String, dynamic> map)
      : image = map['image'] is String ? map['image'] : null,
        url = map['url'] is String ? map['url'] : null,
        isWebView = map['isWebView'] is bool ? map['isWebView'] : false;
}
