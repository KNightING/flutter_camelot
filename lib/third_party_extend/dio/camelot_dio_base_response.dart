import 'package:dio/dio.dart';
import 'package:flutter_camelot/dio_extend.dart';

import 'camelot_dio_service.dart';

typedef CamelotDioResponse<T> = CamelotDioBaseResponse<T, String>;

/// [errorMessage] 錯誤訊息，[CamelotDioService.getErrorMessageOnException]
class CamelotDioBaseResponse<R, E> extends Response<R> {
  CamelotDioBaseResponse({
    required Response response,
    R? data,
    this.error,
  }) : super(
          data: data,
          requestOptions: response.requestOptions,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          isRedirect: response.isRedirect,
          redirects: response.redirects,
          extra: response.extra,
          headers: response.headers,
        );

  R get requireData => data!;

  final CamelotDioError<E>? error;

  bool get hasError => error != null;

  CamelotDioError<E> get requireError => error!;

  bool get hasErrorData => hasError && requireError.hasData;

  E get requireErrorData => requireError.requireData;

  String? get errorMessage => error?.message;
}
