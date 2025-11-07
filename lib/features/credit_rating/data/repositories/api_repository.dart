import 'package:baza_gibdd_gai/core/network/api_client.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/orders_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/payment_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/payment_status.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

typedef JsonMap = Map<String, dynamic>;

const timeout = Duration(seconds: 27);

@injectable
class ApiRepository {
  late final ApiClient apiClient;

  ApiRepository() {
    final dio = Dio();
    dio.interceptors.addAll([]);
    dio.options = BaseOptions(connectTimeout: timeout);
    apiClient = ApiClient(dio);
  }

  Future<ProductModel> getCart() async {
    return await apiClient.getCart();
  }

  Future<PaymentResponse> getPayments(JsonMap body) async {
    return await apiClient.getPayments(body);
  }

  Future<PaymentStatus> checkPayment(String orderId, String userId) async {
    return await apiClient.checkPayment({"orderId": orderId, "userId": userId});
  }

  Future<OrderResponse> getReceivingOrders(String email, String userId) async {
    return await apiClient.getReceivingOrders({
      "email": email,
      "userId": userId,
    });
  }
}
