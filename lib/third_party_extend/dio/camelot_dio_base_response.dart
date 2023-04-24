import 'package:dio/dio.dart';

typedef CamelotDioResponse<T> = CamelotDioBaseResponse<T, String>;

///
/// [errorMessage] 錯誤訊息，[CamelotDioService.getErrorMessageOnException]
class CamelotDioBaseResponse<R, E> extends Response<R> {
  CamelotDioBaseResponse(
      {required Response response,
      R? data,
      this.errorData,
      this.errorMessage,
      this.error})
      : super(
          data: data,
          requestOptions: response.requestOptions,
          statusCode: response.statusCode,
          statusMessage: response.statusMessage,
          isRedirect: response.isRedirect,
          redirects: response.redirects,
          extra: response.extra,
          headers: response.headers,
        ) {}

  R get requireData => data!;

  final dynamic error;

  final E? errorData;

  E get requireErrorData => errorData!;

  final String? errorMessage;

  bool get hasError => errorData != null || errorMessage != null;
}
