import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_camelot/extension.dart';

import '../../log/camelot_log.dart';
import 'camelot_content_encoding_transformer.dart';
import 'camelot_dio_options.dart';

/// [驗證SSL憑證相關資訊](https://github.com/cfug/dio/blob/main/example/lib/certificate_pinning.dart)
/// [如何做https证书校验？](https://github.com/cfug/dio/issues/61)
/// [pem/pfx file](https://stackoverflow.com/questions/70741356/flutter-add-client-certificate-to-request-using-http-dart)
class CamelotDio with DioMixin implements Dio {
  CamelotDio({
    required BaseOptions options,
    required CamelotDioOptions camelotDioOptions,
    Transformer? transformer,
  }) {
    camelotDioOptions.also((cOptions) {
      if (cOptions.writeCamelotLog) {
        interceptors.add(
          LogInterceptor(
            requestBody: true,
            responseBody: true,
            logPrint: (s) => CLog.debug(s),
          ),
        );
      }
      httpClientAdapter = cOptions.httpClientAdapter ?? HttpClientAdapter();

      var acceptEncoding = '';
      for (var encoding in cOptions.acceptEncoding) {
        final encodingStr = switch (encoding) {
          CamelotContentEncoding.brotli => brotliStr,
          CamelotContentEncoding.gzip => gzipStr,
          _ => ''
        };

        if (encodingStr.isNotEmpty) {
          if (acceptEncoding.isEmpty) {
            acceptEncoding = encodingStr;
          } else {
            acceptEncoding += ', $encodingStr';
          }
        }
      }

      if (acceptEncoding.isNotEmpty) {
        options.headers.putIfAbsent('Accept-Encoding', () => acceptEncoding);
      }
    });

    this.options = options;
    this.transformer = transformer ?? CamelotContentEncodingTransformer();
  }
}
