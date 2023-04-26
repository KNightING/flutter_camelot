import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class CamelotDioOptions {
  CamelotDioOptions({
    // this.interceptors,
    this.writeCamelotLog = kDebugMode,
    this.writeBodyForLog = true,
    this.httpClientAdapter,
  });

  final HttpClientAdapter? httpClientAdapter;

  // final List<Interceptor>? interceptors;

  final bool writeCamelotLog;

  final bool writeBodyForLog;
}