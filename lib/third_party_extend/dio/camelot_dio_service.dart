import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_camelot/dio_extend.dart';

typedef ResponseParse<T> = T Function(Response response);

abstract class CamelotDioService {
  CamelotDioService({
    required BaseOptions options,
    required CamelotDioOptions camelotDioOptions,
  }) : _dio = CamelotDio(
          options: options,
          camelotDioOptions: camelotDioOptions,
        );

  final CamelotDio _dio;

  CamelotDio get dio => _dio;

  addInterceptor(Interceptor interceptor) {
    _dio.interceptors.add(interceptor);
  }

  /// 發生異常時，提供[CamelotDioBaseResponse.errorMessage]錯誤訊息
  /// 如需要請override自行定義
  String getErrorMessageOnException(dynamic error) {
    return 'have some wrong, please try again.';
  }

  /// 如果錯誤response有客製的錯誤訊息格式，請override[E]類型的[toString]
  Future<CamelotDioBaseResponse<T, E>> _getFailureResponse<T, E>(
    dynamic error,
    StackTrace? trace, {
    required String path,
    Map<String, dynamic>? reqQueryParameters,
    Object? reqData,
    Options? reqOptions,
    required ResponseParse<E> errorParse,
  }) async {
    if (error is DioError) {
      final errorRequestOptions = error.requestOptions;
      final errorResponse = error.response;

      if (errorResponse == null) {
        return CamelotDioBaseResponse(
          response: Response(requestOptions: errorRequestOptions),
          error: CamelotDioError<E>.fromDioError(
            error,
            message: getErrorMessageOnException(error),
          ),
        );
      }

      final errorData = await compute(errorParse, errorResponse);
      final errorMessage = errorData.toString();

      return CamelotDioBaseResponse(
        response: errorResponse,
        error: CamelotDioError<E>.fromDioError(
          error,
          data: errorData,
          message: errorMessage,
        ),
      );
    }

    final requestOptions = RequestOptions(
      path: path,
      data: reqData,
      queryParameters: reqQueryParameters,
      headers: reqOptions?.headers,
    );

    return CamelotDioBaseResponse(
      response: Response(
        requestOptions: requestOptions,
      ),
      error: CamelotDioError<E>.fromError(
        error,
        trace,
        requestOptions: requestOptions,
        message: getErrorMessageOnException(error),
      ),
    );
  }

  /// [R] 呼叫API成功的格式類型
  /// [E] 呼叫API有response但是錯誤且body有內容時的格式類型
  /// [parse] 將body轉換成 [R]，會在[compute]內轉換，故無法使用方法傳遞，會發生錯誤，如下
  /// * 注意: 因為在[parse]、[errorParse]皆在不同[Isolate]下轉換，所以記憶體資源不會共用
  /// ```dart
  /// R parse(response){
  ///   //do parse
  /// }
  ///
  /// E errorParse(response){
  ///   //do parse
  /// }
  ///
  /// Future<CamelotDioBaseResponse<String, String>> getTest() {
  ///     return get(
  ///       '/test',
  ///       parse: parse,
  ///       errorParse: : errorParse,
  ///     );
  ///   }
  /// ```
  ///
  /// 可以如下
  ///
  /// ```dart
  ///
  /// ResponseParse<E> errorParse = (response){
  ///   //do parse
  /// };
  ///
  /// Future<CamelotDioBaseResponse<String, String>> getTest() {
  ///     return get(
  ///       '/test',
  ///       parse: (response) => response.data.toString(),
  ///       errorParse: : errorParse,
  ///     );
  ///   }
  /// ```
  ///
  /// [errorParse] 將body轉換成[E]，用法同[parse]
  ///
  /// ```dart
  /// Future<CamelotDioBaseResponse<String, String>> getTest() {
  ///     return get(
  ///       '/test',
  ///       parse: (response) => response.data.toString(),
  ///       errorParse: : (response) => response.data.toString(),
  ///     );
  ///   }
  /// ```
  /// 或可以使用fromJson
  ///
  /// ```dart
  /// Future<CamelotDioResponse<R>> getTest() {
  ///     return get(
  ///       '/test',
  ///       parse: (response) => R.fromJson(response.data),
  ///       errorParse: : (response) => response.data.toString(),
  ///     );
  ///   }
  /// ```
  /// 注意
  /// [CamelotDioResponse]為[CamelotDioBaseResponse]擴充，只是[E]類型固定為[String]
  Future<CamelotDioBaseResponse<R, E>> get<R, E>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    required ResponseParse<R> parse,
    required ResponseParse<E> errorParse,
  }) async {
    try {
      final response = await _dio.get(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );

      final dataFromParse = await compute(parse, response);

      return CamelotDioBaseResponse<R, E>(
        response: response,
        data: dataFromParse,
      );
    } catch (error, trace) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        trace,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      return failureResponse;
    }
  }

  /// 用法請參考[get]
  Future<CamelotDioBaseResponse<R, E>> post<R, E>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required ResponseParse<R> parse,
    required ResponseParse<E> errorParse,
  }) async {
    try {
      final response = await _dio.post(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      final dataFromParse = await compute(parse, response);

      return CamelotDioBaseResponse(
        response: response,
        data: dataFromParse,
      );
    } catch (error, trace) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        trace,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      return failureResponse;
    }
  }

  /// 用法請參考[get]
  Future<CamelotDioBaseResponse<R, E>> patch<R, E>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required ResponseParse<R> parse,
    required ResponseParse<E> errorParse,
  }) async {
    try {
      final response = await _dio.patch(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      final dataFromParse = await compute(parse, response);

      return CamelotDioBaseResponse(
        response: response,
        data: dataFromParse,
      );
    } catch (error, trace) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        trace,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      return failureResponse;
    }
  }

  /// 用法請參考[get]
  Future<CamelotDioBaseResponse<R, E>> put<R, E>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    required ResponseParse<R> parse,
    required ResponseParse<E> errorParse,
  }) async {
    try {
      final response = await _dio.put(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );

      final dataFromParse = await compute(parse, response);

      return CamelotDioBaseResponse(
        response: response,
        data: dataFromParse,
      );
    } catch (error, trace) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        trace,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      return failureResponse;
    }
  }

  /// 用法請參考[get]
  Future<CamelotDioBaseResponse<R, E>> delete<R, E>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    required ResponseParse<R> parse,
    required ResponseParse<E> errorParse,
  }) async {
    try {
      final response = await _dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
        options: options,
        cancelToken: cancelToken,
      );

      final dataFromParse = await compute(parse, response);

      return CamelotDioBaseResponse(
        response: response,
        data: dataFromParse,
      );
    } catch (error, trace) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        trace,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      return failureResponse;
    }
  }
}
