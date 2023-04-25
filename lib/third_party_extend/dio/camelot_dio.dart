import 'package:dio/dio.dart';
import 'package:flutter_camelot/extension.dart';

import '../../log/camelot_log.dart';
import 'camelot_dio_options.dart';

///
/// [驗證SSL憑證相關資訊](https://github.com/cfug/dio/blob/main/example/lib/certificate_pinning.dart)
/// [如何做https证书校验？](https://github.com/cfug/dio/issues/61)
/// [pem/pfx file](https://stackoverflow.com/questions/70741356/flutter-add-client-certificate-to-request-using-http-dart)
///
class CamelotDio with DioMixin implements Dio {
  CamelotDio({
    required BaseOptions options,
    required CamelotDioOptions camelotDioOptions,
  }) {
    this.options = options;
    camelotDioOptions.also((cOptions) {
      if (cOptions.writeCamelotLog) {
        interceptors.add(
          LogInterceptor(
            requestBody: cOptions.writeBodyForLog,
            responseBody: cOptions.writeBodyForLog,
            logPrint: (s) => CLog.debug(s),
          ),
        );
      }
      // cOptions.interceptors?.also((it) => interceptors.addAll(it));
      httpClientAdapter = cOptions.httpClientAdapter ?? HttpClientAdapter();
    });
  }
}
