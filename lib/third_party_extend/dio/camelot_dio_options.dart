import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_camelot/dio_extend.dart';

const List<CamelotContentEncoding> defaultAcceptEncoding = [
  CamelotContentEncoding.brotli,
  CamelotContentEncoding.gzip,
];

class CamelotDioOptions {
  CamelotDioOptions({
    this.writeCamelotLog = kDebugMode,
    this.httpClientAdapter,
    this.acceptEncoding = defaultAcceptEncoding
  });

  final HttpClientAdapter? httpClientAdapter;

  final bool writeCamelotLog;

  final List<CamelotContentEncoding> acceptEncoding;
}
