class RequestModel {
  final String userId;
  final String email;
  final List<ProductModel> products;

  RequestModel({
    required this.userId,
    required this.email,
    required this.products,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) {
    return RequestModel(
      userId: json['userId'],
      email: json['email'],
      products: (json['products'] as List)
          .map((item) => ProductModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'email': email,
      'products': products.map((product) => product.toJson()).toList(),
    };
  }
}

class ProductModel {
  final String id;
  final ServiceParams serviceParams;

  ProductModel({
    required this.id,
    required this.serviceParams,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      serviceParams: ServiceParams.fromJson(json['serviceParams']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceParams': serviceParams.toJson(),
    };
  }
}

class ServiceParams {
  final String surname;
  final String name;
  final String? patronymic;
  final String birthDate;
  final String inn;
  final String passportSeriesNumber;
  final String passportDateIssue;
  final String passportIssuerCode;

  ServiceParams({
    required this.surname,
    required this.name,
    this.patronymic,
    required this.birthDate,
    required this.inn,
    required this.passportSeriesNumber,
    required this.passportDateIssue,
    required this.passportIssuerCode,
  });

  factory ServiceParams.fromJson(Map<String, dynamic> json) {
    return ServiceParams(
      surname: json['surname'],
      name: json['name'],
      patronymic: json['patronymic'],
      birthDate: json['birthDate'],
      inn: json['inn'],
      passportSeriesNumber: json['passportSeriesNumber'],
      passportDateIssue: json['passportDateIssue'],
      passportIssuerCode: json['passportIssuerCode'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'surname': surname,
      'name': name,
      'patronymic': patronymic,
      'birthDate': birthDate,
      'inn': inn,
      'passportSeriesNumber': passportSeriesNumber,
      'passportDateIssue': passportDateIssue,
      'passportIssuerCode': passportIssuerCode,
    };
  }
}
