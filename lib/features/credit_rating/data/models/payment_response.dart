import 'package:baza_gibdd_gai/features/credit_rating/data/models/product_model.dart';

class PaymentResponse {
  final bool success;
  final Cart? cart;
  final String? error;

  PaymentResponse({
    required this.success,
    required this.cart,
    required this.error,
  });

  factory PaymentResponse.fromJson(Map<String, dynamic> json) {
    return PaymentResponse(
      success: json['success'] ?? false,
      cart: json['cart'] != null ? Cart.fromJson(json['cart']) : null,
      error: json['error'],
    );
  }
}

class Cart {
  final List<AvailableProduct> items;
  final int price;
  final int discountPrice;
  final int discount;
  final String email;
  final String orderId;
  final String paymentUrl;

  Cart({
    required this.items,
    required this.price,
    required this.discountPrice,
    required this.discount,
    required this.email,
    required this.orderId,
    required this.paymentUrl,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    var itemsList = (json['items'] as List)
        .map((item) => AvailableProduct.fromJson(item))
        .toList();
    return Cart(
      items: itemsList,
      price: json['price'],
      discountPrice: json['discountPrice'],
      discount: json['discount'],
      email: json['email'],
      orderId: json['orderId'],
      paymentUrl: json['paymentUrl'],
    );
  }
}
