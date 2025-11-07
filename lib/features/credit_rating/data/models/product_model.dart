class ProductModel {
  final bool success;
  final AvailableProduct? availableProduct;
  final String? error;

  ProductModel({
    required this.success,
    required this.availableProduct,
    required this.error,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      success: json['success'] ?? false,
      availableProduct: json['availableProduct'] != null
          ? AvailableProduct.fromJson(json['availableProduct'])
          : null,
      error: json['error'],
    );
  }
}

class AvailableProduct {
  final String id;
  final String title;
  final String description;
  final int price;
  final int discountPrice;
  final int discount;
  final String productType;
  final String orderType;
  final ServiceParams serviceParams;

  AvailableProduct({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.discountPrice,
    required this.discount,
    required this.productType,
    required this.orderType,
    required this.serviceParams,
  });

  factory AvailableProduct.fromJson(Map<String, dynamic> json) {
    return AvailableProduct(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      price: json['price'],
      discountPrice: json['discountPrice'],
      discount: json['discount'],
      productType: json['productType'],
      orderType: json['orderType'],
      serviceParams: ServiceParams.fromJson(json['serviceParams']),
    );
  }
}

class ServiceParams {
  final Map<String, Field> fields;

  ServiceParams({required this.fields});

  factory ServiceParams.fromJson(Map<String, dynamic> json) {
    Map<String, Field> fieldsMap = {};
    json['fields'].forEach((key, value) {
      fieldsMap[key] = Field.fromJson(value);
    });
    return ServiceParams(fields: fieldsMap);
  }
}

class Field {
  final String title;
  final String regexp;
  final bool required;

  Field({
    required this.title,
    required this.regexp,
    required this.required,
  });

  factory Field.fromJson(Map<String, dynamic> json) {
    return Field(
      title: json['title'],
      regexp: json['regexp'],
      required: json['required'],
    );
  }
}
