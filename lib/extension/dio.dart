import 'package:dio/dio.dart';

extension DioResponseExtension on Response {
  bool get isSuccessful {
    final code = statusCode;
    return code != null && code >= 200 && code < 300;
  }
}
