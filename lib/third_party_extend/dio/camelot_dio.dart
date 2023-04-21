import 'package:dio/dio.dart';
import 'package:flutter_camelot/extension.dart';

import '../../log/camelot_log.dart';
import 'camelot_dio_options.dart';

class CamelotDio with DioMixin implements Dio {
  CamelotDio({
    required BaseOptions options,
    required CamelotDioOptions camelotDioOptions,
  }) {
    this.options = options;
    camelotDioOptions.also((cOptions) {
      if (cOptions.writeCamelotLog) {
        interceptors.add(LogInterceptor(logPrint: (s) => CLog.debug(s)));
      }
      // cOptions.interceptors?.also((it) => interceptors.addAll(it));
      httpClientAdapter = cOptions.httpClientAdapter ?? HttpClientAdapter();
    });
  }
}