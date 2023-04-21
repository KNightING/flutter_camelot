import 'package:dio/dio.dart';

typedef CamelotDioResponse<T> = CamelotDioBaseResponse<T, String>;

class CamelotDioBaseResponse<R, E> extends Response<R> {
  CamelotDioBaseResponse({
    required Response response,
    R? data,
    this.errorData,
    this.errorMessage,
  }) : super(
    data: data,
    requestOptions: response.requestOptions,
    statusCode: response.statusCode,
    statusMessage: response.statusMessage,
    isRedirect: response.isRedirect,
    redirects: response.redirects,
    extra: response.extra,
    headers: response.headers,
  ) {}

  final E? errorData;

  final String? errorMessage;

  bool get hasError => errorData != null || errorMessage != null;
}