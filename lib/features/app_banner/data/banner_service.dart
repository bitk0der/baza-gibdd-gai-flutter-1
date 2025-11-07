import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:logger/logger.dart';
import 'package:baza_gibdd_gai/core/network/api_path.dart';
import 'package:baza_gibdd_gai/features/app_banner/app_banner_initial_setup.dart';

class AppBannerService {
  final Dio _dio = Dio(
    BaseOptions(
      connectTimeout: const Duration(minutes: 2),
      receiveTimeout: const Duration(minutes: 2),
    ),
  );

  AppBannerService() {
    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };
  }

  Future<dynamic> getAppBanner() async {
    try {
      final response = await _dio.get(
        ApiPath.banners,
        queryParameters: {
          'bundle': packageInfo.packageName,
          'platform': Platform.isAndroid ? 'android' : 'ios',
        },
      );
      return jsonDecode(response.data);
    } catch (e) {
      Logger().e(e);
      return [];
    }
  }

  Future<bool> getModerationModStatus() async {
    try {
      return true;
      /*  final response = await _dio.get(
        "https://eaisto-m.com/appsconfig.php",
        queryParameters: {
          'bundle': 'egrn.booking.ru',
        },
      );
      bool val = false;
      if (response.data is String) {
        val = jsonDecode(response.data)['indigo'];
      } else {
        val = response.data['indigo'];
      }
      return val; */
    } catch (e) {
      Logger().e(e);
    }
    return false;
  }
}
