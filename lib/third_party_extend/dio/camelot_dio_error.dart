import 'package:dio/dio.dart';

class CamelotDioError<E> extends DioError {
  CamelotDioError.fromDioError(
      DioError error, {
        this.data,
        required super.message,
      })  : fromDioError = true,
        super(
        requestOptions: error.requestOptions,
        response: error.response,
        type: error.type,
        error: error.error,
        stackTrace: error.stackTrace,
      );

  CamelotDioError.fromError(
      dynamic error,
      StackTrace? trace, {
        this.data,
        required super.message,
        required RequestOptions requestOptions,
      })  : fromDioError = false,
        super(
        requestOptions: requestOptions,
        error: error,
        stackTrace: trace,
      );

  final bool fromDioError;

  final E? data;

  bool get hasData => data != null;

  E get requireData => data!;

  @override
  String toString() {
    return super.message ?? super.toString();
  }
}
