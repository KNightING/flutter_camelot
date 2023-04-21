import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

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

  String getErrorMessageOnException(Exception error) {
    return 'have some wrong, please try again.';
  }

  Future<CamelotDioBaseResponse<T, E>> _getFailureResponse<T, E>(
    dynamic error, {
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
          errorMessage: getErrorMessageOnException(error),
          error: error,
        );
      }

      final errorDataFromParse = await compute(errorParse, errorResponse);

      return CamelotDioBaseResponse(
        response: errorResponse,
        errorData: errorDataFromParse,
        error: error,
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
      errorMessage: getErrorMessageOnException(error),
      error: error,
    );
  }

  Future<bool> doRefreshToken() async {
    return true;
  }

  bool shouldRefreshToken(dynamic error) {
    return error is DioError && error.response?.statusCode == 401;
  }

  Future<CamelotDioBaseResponse<R, E>> get<R, E>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    required ResponseParse<R> parse,
    required ResponseParse<E> errorParse,
    bool refreshToken = false,
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
    } catch (error) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      if (refreshToken && shouldRefreshToken(error)) {
        final refreshTokenResult = await doRefreshToken();

        if (!refreshTokenResult) {
          return failureResponse;
        }

        return get<R, E>(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          parse: parse,
          errorParse: errorParse,
          refreshToken: false,
        );
      }

      return failureResponse;
    }
  }

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
    bool refreshToken = false,
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
    } catch (error) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      if (refreshToken && shouldRefreshToken(error)) {
        final refreshTokenResult = await doRefreshToken();

        if (!refreshTokenResult) {
          return failureResponse;
        }

        return post<R, E>(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          parse: parse,
          errorParse: errorParse,
          refreshToken: false,
        );
      }

      return failureResponse;
    }
  }

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
    bool refreshToken = false,
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
    } catch (error) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      if (refreshToken && shouldRefreshToken(error)) {
        final refreshTokenResult = await doRefreshToken();

        if (!refreshTokenResult) {
          return failureResponse;
        }

        return patch<R, E>(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          parse: parse,
          errorParse: errorParse,
          refreshToken: false,
        );
      }

      return failureResponse;
    }
  }

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
    bool refreshToken = false,
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
    } catch (error) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      if (refreshToken && shouldRefreshToken(error)) {
        final refreshTokenResult = await doRefreshToken();

        if (!refreshTokenResult) {
          return failureResponse;
        }

        return put<R, E>(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
          onSendProgress: onSendProgress,
          onReceiveProgress: onReceiveProgress,
          parse: parse,
          errorParse: errorParse,
          refreshToken: false,
        );
      }

      return failureResponse;
    }
  }

  Future<CamelotDioBaseResponse<R, E>> delete<R, E>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
    Options? options,
    CancelToken? cancelToken,
    required ResponseParse<R> parse,
    required ResponseParse<E> errorParse,
    bool refreshToken = false,
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
    } catch (error) {
      final failureResponse = _getFailureResponse<R, E>(
        error,
        path: path,
        reqData: data,
        reqOptions: options,
        reqQueryParameters: queryParameters,
        errorParse: errorParse,
      );

      if (refreshToken && shouldRefreshToken(error)) {
        final refreshTokenResult = await doRefreshToken();

        if (!refreshTokenResult) {
          return failureResponse;
        }

        return delete<R, E>(
          path,
          queryParameters: queryParameters,
          data: data,
          options: options,
          cancelToken: cancelToken,
          parse: parse,
          errorParse: errorParse,
          refreshToken: false,
        );
      }

      return failureResponse;
    }
  }
}
