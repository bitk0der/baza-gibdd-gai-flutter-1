import 'dart:convert';

class Field {
  final String title;
  final String regexp;
  final bool required;
  final String value;

  Field(
      {required this.title,
      required this.regexp,
      required this.required,
      required this.value});

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      title: json['title'],
      regexp: json['regexp'],
      required: json['required'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'regexp': regexp,
      'required': required,
      'value': value,
    };
  }
}

class ServiceParams {
  final Map<String, Field> fields;

  ServiceParams({required this.fields});

  factory ServiceParams.fromJson(Map<String, dynamic> json) {
    return ServiceParams(
      fields: (json['fields'] as Map<String, dynamic>).map(
        (key, value) => MapEntry(key, Field.fromJson(value)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'fields': fields.map((key, value) => MapEntry(key, value.toJson())),
    };
  }
}

class OrderModel {
  final String id;
  final String egrn;
  final String name;
  final String region;
  final String date;
  final bool ready;
  final String type;
  final int dateTimestamp;
  final String dateStr;
  final ServiceParams serviceParams;
  final DownloadLinksList downloadLinks;
  OrderModel({
    required this.id,
    required this.egrn,
    required this.name,
    required this.region,
    required this.date,
    required this.ready,
    required this.type,
    required this.dateTimestamp,
    required this.dateStr,
    required this.serviceParams,
    required this.downloadLinks,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
        id: json['id'],
        egrn: json['egrn'],
        name: json['name'],
        region: json['region'],
        date: json['date'],
        ready: json['ready'],
        type: json['type'],
        dateTimestamp: json['dateTimestamp'],
        dateStr: json['dateStr'],
        serviceParams: ServiceParams.fromJson(json['serviceParams']),
        downloadLinks: DownloadLinksList.fromJson(json));
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'egrn': egrn,
      'name': name,
      'region': region,
      'date': date,
      'ready': ready,
      'type': type,
      'dateTimestamp': dateTimestamp,
      'dateStr': dateStr,
      'serviceParams': serviceParams.toJson(),
    };
  }
}

class OrderResponse {
  final bool success;
  final List<OrderModel> items;
  final String? error;

  OrderResponse(
      {required this.success, required this.items, required this.error});

  factory OrderResponse.fromJson(Map<String, dynamic> jsonData) {
    return OrderResponse(
      success: jsonData['success'] ?? false,
      error: jsonData['error'],
      items: jsonData['items'] == null
          ? []
          : (jsonData['items'] as List)
              .map((i) => OrderModel.fromJson(i))
              .toList(),
    );
  }

  String toJson() {
    final Map<String, dynamic> jsonData = {
      'success': success,
      'items': items.map((i) => i.toJson()).toList(),
    };
    return jsonEncode(jsonData);
  }
}

class DownloadLink {
  final String type;
  final String title;
  final String url;

  DownloadLink({
    required this.type,
    required this.title,
    required this.url,
  });

  // Фабричный метод для создания объекта из JSON
  factory DownloadLink.fromJson(Map<String, dynamic> json) {
    return DownloadLink(
      type: json['type'],
      title: json['title'],
      url: json['url'],
    );
  }

  // Метод для преобразования объекта в JSON
  Map<String, dynamic> toJson() {
    return {
      'type': type,
      'title': title,
      'url': url,
    };
  }
}

class DownloadLinksList {
  final List<DownloadLink> downloadLinks;

  DownloadLinksList({required this.downloadLinks});

  // Фабричный метод для создания списка объектов из JSON
  factory DownloadLinksList.fromJson(Map<String, dynamic> json) {
    var list =
        json['downloadLinks'] == null ? [] : json['downloadLinks'] as List;
    List<DownloadLink> links =
        list.map((i) => DownloadLink.fromJson(i)).toList();
    return DownloadLinksList(downloadLinks: links);
  }

  // Метод для преобразования списка объектов в JSON
  Map<String, dynamic> toJson() {
    return {
      'downloadLinks': downloadLinks.map((e) => e.toJson()).toList(),
    };
  }
}
