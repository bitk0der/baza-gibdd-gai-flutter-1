import 'package:baza_gibdd_gai/features/chat_with_gpt/data/models/message_model.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/data/repositories/api_repository.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/orders_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/payment_response.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/payment_status.dart';
import 'package:baza_gibdd_gai/features/credit_rating/data/models/product_model.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:baza_gibdd_gai/core/network/api_path.dart';
part 'api_client.g.dart';

@injectable
@RestApi(baseUrl: ApiPath.baseUrl)
abstract class ApiClient {
  @factoryMethod
  factory ApiClient(Dio dio) = _ApiClient;

  @POST(ApiPath.sendMessage)
  Future<UserDialogResponse> sendMessage(@Body() JsonMap body);

  @POST(ApiPath.getLastMessage)
  Future<MessagesResponse> getLastMessage(@Body() JsonMap body);

  @POST(ApiPath.getLastMessage)
  Future<MessagesResponse> getBackgroundNotification();

  @GET(ApiPath.getCart)
  Future<ProductModel> getCart();

  @POST(ApiPath.getPaymentLink)
  Future<PaymentResponse> getPayments(@Body() JsonMap body);

  @POST(ApiPath.checkPayment)
  Future<PaymentStatus> checkPayment(@Body() JsonMap body);

  @POST(ApiPath.getReceivingOrders)
  Future<OrderResponse> getReceivingOrders(@Body() JsonMap body);
}
