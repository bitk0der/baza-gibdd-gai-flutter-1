import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:baza_gibdd_gai/core/network/api_client.dart';
import 'package:baza_gibdd_gai/features/chat_with_gpt/data/models/message_model.dart';
import 'package:baza_gibdd_gai/features/local_notifications/data/models/response_message_model.dart';

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

  Future<UserDialogResponse> sendMessage(JsonMap body) async {
    return await apiClient.sendMessage(body);
  }

  Future<MessagesResponse> getLastMessage(JsonMap body) async {
    return await apiClient.getLastMessage(body);
  }
}
