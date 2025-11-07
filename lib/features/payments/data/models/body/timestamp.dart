import 'dart:convert';
import 'package:crypto/crypto.dart';


class Timestamp{
  static String generate(Map<String, dynamic> request, [String key = '98NNjd78']){
    String resultString = '';
    for (var key in request.keys.toList()
      ..sort()) {
      resultString += jsonEncode(request[key]);
    }
    resultString += key;
    return md5.convert(utf8.encode(resultString)).toString();
  }
}