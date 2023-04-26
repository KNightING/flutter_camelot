import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_camelot/extension/dio_extension.dart';

import 'camelot_dio.dart';
import 'camelot_dio_base_response.dart';
import 'camelot_dio_options.dart';

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
          // errorMessage: getErrorMessageOnException(error),
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
        // errorData: errorData,
        error: CamelotDioError<E>.fromDioError(
          error,
          data: errorData,
          message: errorMessage,
        ),
        // errorMessage: errorMessage,
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
      // errorMessage: getErrorMessageOnException(error),
      error: CamelotDioError<E>.fromError(
        error,
        trace,
        requestOptions: requestOptions,
        message: getErrorMessageOnException(error),
      ),
    );
  }

  // /// 刷新token
  // /// 回傳成功與否
  // Future<bool> doRefreshToken() async {
  //   return true;
  // }
  //
  // /// 是否進行刷新，預設會在獲得response status code 為 401時刷新
  // bool shouldRefreshToken(dynamic error) {
  //   return error is DioError && error.response?.isUnauthorized == true;
  // }

  /// [R] 呼叫API成功的格式類型
  /// [E] 呼叫API有response但是錯誤且body有內容時的格式類型
  /// [parse] 將body轉換成 [R]
  /// [errorParse] 將body轉換成[E]
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
    // bool refreshToken = false,
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

      // if (refreshToken && shouldRefreshToken(error)) {
      //   final refreshTokenResult = await doRefreshToken();
      //
      //   if (!refreshTokenResult) {
      //     return failureResponse;
      //   }
      //
      //   return get<R, E>(
      //     path,
      //     queryParameters: queryParameters,
      //     data: data,
      //     options: options,
      //     cancelToken: cancelToken,
      //     onReceiveProgress: onReceiveProgress,
      //     parse: parse,
      //     errorParse: errorParse,
      //     refreshToken: false,
      //   );
      // }

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
    // bool refreshToken = false,
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

      // if (refreshToken && shouldRefreshToken(error)) {
      //   final refreshTokenResult = await doRefreshToken();
      //
      //   if (!refreshTokenResult) {
      //     return failureResponse;
      //   }
      //
      //   return post<R, E>(
      //     path,
      //     queryParameters: queryParameters,
      //     data: data,
      //     options: options,
      //     cancelToken: cancelToken,
      //     onSendProgress: onSendProgress,
      //     onReceiveProgress: onReceiveProgress,
      //     parse: parse,
      //     errorParse: errorParse,
      //     refreshToken: false,
      //   );
      // }

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
    // bool refreshToken = false,
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

      // if (refreshToken && shouldRefreshToken(error)) {
      //   final refreshTokenResult = await doRefreshToken();
      //
      //   if (!refreshTokenResult) {
      //     return failureResponse;
      //   }
      //
      //   return patch<R, E>(
      //     path,
      //     queryParameters: queryParameters,
      //     data: data,
      //     options: options,
      //     cancelToken: cancelToken,
      //     onSendProgress: onSendProgress,
      //     onReceiveProgress: onReceiveProgress,
      //     parse: parse,
      //     errorParse: errorParse,
      //     refreshToken: false,
      //   );
      // }

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
    // bool refreshToken = false,
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

      // if (refreshToken && shouldRefreshToken(error)) {
      //   final refreshTokenResult = await doRefreshToken();
      //
      //   if (!refreshTokenResult) {
      //     return failureResponse;
      //   }
      //
      //   return put<R, E>(
      //     path,
      //     queryParameters: queryParameters,
      //     data: data,
      //     options: options,
      //     cancelToken: cancelToken,
      //     onSendProgress: onSendProgress,
      //     onReceiveProgress: onReceiveProgress,
      //     parse: parse,
      //     errorParse: errorParse,
      //     refreshToken: false,
      //   );
      // }

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
    // bool refreshToken = false,
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

      // if (refreshToken && shouldRefreshToken(error)) {
      //   final refreshTokenResult = await doRefreshToken();
      //
      //   if (!refreshTokenResult) {
      //     return failureResponse;
      //   }
      //
      //   return delete<R, E>(
      //     path,
      //     queryParameters: queryParameters,
      //     data: data,
      //     options: options,
      //     cancelToken: cancelToken,
      //     parse: parse,
      //     errorParse: errorParse,
      //     refreshToken: false,
      //   );
      // }

      return failureResponse;
    }
  }
}

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
}
