import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';
import 'package:baza_gibdd_gai/core/network/api_path.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_fssp_trial.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_invoice.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/api_models/api_to_pay_element.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/body/timestamp.dart';
import 'package:baza_gibdd_gai/features/payments/data/models/fsin_model.dart';

@injectable
class RestService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(milliseconds: 120 * 1000),
      receiveTimeout: const Duration(milliseconds: 120 * 1000),
    ),
  );
  int _requestCount = 0;
  int _failedRequestCounter = 0;

  RestService() {
    (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  int _errorCount = 0;

  Future<List> searchDebt(Map<String, dynamic> body) async {
    Logger().i(body);
    int attemptCount = 0;

    while (attemptCount < 12) {
      try {
        final response = await _dio.post(
          "https://moneta.avtoapi.ru/search/v2/fsspgibdd",
          data: body,
        );

        if (response.data["processing"] != null) {
          // Если еще обрабатывается, ждем 3 секунды и повторяем
          attemptCount++;
          await Future.delayed(const Duration(seconds: 10));
        } else {
          // Если обработка завершена, возвращаем результат
          return response.data["result"];
        }
      } catch (e) {
        _errorCount++;
        print(_errorCount);
        if (_errorCount < 12) {
          // Если ошибка, пробуем снова
          await Future.delayed(
            const Duration(seconds: 10),
          ); // добавляем задержку перед повторной попыткой
          continue;
        } else {
          _errorCount = 0;
          Logger().e(e);
          return [];
        }
      }
    }

    // Если все попытки исчерпаны
    return [];
  }

  Future<List<Fsin>> loadFsin() async {
    List<Fsin> responsesList = [];
    final response = await _dio.get(ApiPath.loadFsin());
    if (_failedRequestCounter == 10) throw Exception();
    if (response.statusCode != 200 ||
        (response.data is List && response.data.isEmpty)) {
      await Future.delayed(const Duration(seconds: 3));
      _failedRequestCounter++;
      return loadFsin();
    } else {
      _failedRequestCounter = 0;
      for (var element in response.data) {
        responsesList.add(Fsin.fromMap(element));
      }
      return responsesList;
    }
  }

  Future<List<ApiInvoice>> getInvoiceInfo(Map<String, dynamic> body) async {
    Logger().i(body);
    final response = await _dio.post(ApiPath.getInvoiceInfo(),
        data: body, options: Options(contentType: Headers.jsonContentType));
    List result = response.data['result'];
    List<ApiInvoice> invoicesList = [];
    result.forEach((element) {
      List<ApiToPayElement> toPayElements = [];
      List toPayElementsMapList = element['toPayElements'];
      toPayElementsMapList.forEach((toPayElement) {
        toPayElements.add(ApiToPayElement.fromMap(toPayElement));
      });
      invoicesList.add(ApiInvoice.fromMap(element, toPayElements));
    });
    return invoicesList;
  }

  Future<List<ApiFsspTrial>> searchFsspDebt(Map<String, dynamic> body) async {
    Logger().i(body);
    _requestCount = 0;
    final response =
        await _dio.get(ApiPath.getDoSearch(), queryParameters: body);
    if (response.data["error"] != null) {
      throw (Exception(response.data["error"]));
    }
    if (response.data["taskid"] == null) throw (Exception('Task id == null'));
    final result = await _getResult(
      taskId: response.data["taskid"].toString(),
      duration: const Duration(seconds: 3),
    );
    final List resultList = result["result"];
    List<ApiFsspTrial> responsesList = [];
    resultList.forEach((element) {
      responsesList.add(ApiFsspTrial.fromMap(element));
    });
    return responsesList;
  }

  Future<Map<String, dynamic>> _getResult({
    required String taskId,
    required Duration duration,
  }) async {
    _requestCount++;
    if (_requestCount > 60) {
      _requestCount = 0;
      throw ('Native timeout');
    }
    Map<String, dynamic> parameters = {"taskid": taskId};
    parameters.addAll({"timestamp": Timestamp.generate(parameters, "Jkdus7")});
    final response =
        await _dio.get(ApiPath.getResult(), queryParameters: parameters);
    if (response.data["status"] == "inprocess") {
      await Future.delayed(duration);
      return _getResult(
          taskId: taskId, duration: const Duration(milliseconds: 1500));
    } else {
      _requestCount = 0;
      return response.data;
    }
  }
}
