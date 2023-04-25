import 'package:dio/dio.dart';
import 'package:flutter_camelot/extension/dio_extension.dart';
import 'package:flutter_camelot/third_party_extend/dio/camelot_dio.dart';

class CamelotDioAuthBaseInterceptor extends Interceptor {
  CamelotDioAuthBaseInterceptor(this.dio);

  final CamelotDio dio;

  /// 設定token的邏輯
  Future<bool> setToken(RequestOptions options) async {
    return true;
  }

  /// 檢核是否刷新token
  /// 預設會檢查401與403
  Future<bool> needRefreshToken(
    DioError error,
    ErrorInterceptorHandler handler,
  ) async {
    return error.response?.isUnauthorized == true ||
        error.response?.isForbidden == true;
  }

  /// 刷新token的邏輯。
  /// 回傳true，則會進行[retry]
  /// 回傳false，則會呼叫[onError]，並將原本的error傳回去
  Future<bool> doRefreshToken(
    CamelotDio dio,
    DioError error,
    ErrorInterceptorHandler handler,
  ) async {
    return true;
  }

  /// [doRefreshToken]回傳true後會進行重新請求。
  /// 會重新呼叫[setToken]，如果回傳false，則會呼叫[onError]，並將原本的error傳回去
  Future<void> retry(
    CamelotDio dio,
    DioError err,
    ErrorInterceptorHandler handler,
  ) async {
    final requestOptions = err.requestOptions;
    // reset token
    if (await setToken(requestOptions) == false) {
      super.onError(err, handler);
      return;
    }
    final cloneOptions = requestOptions.toOptions();
    final response = await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      cancelToken: requestOptions.cancelToken,
      options: cloneOptions,
      onSendProgress: requestOptions.onSendProgress,
      onReceiveProgress: requestOptions.onReceiveProgress,
    );
    return handler.resolve(response);
  }

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (await setToken(options)) {
      super.onRequest(options, handler);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    if (await needRefreshToken(err, handler) &&
        await doRefreshToken(dio, err, handler)) {
      retry(dio, err, handler);
    } else {
      super.onError(err, handler);
    }
  }
}

class CamelotDioBearerAuthInterceptor extends CamelotDioAuthBaseInterceptor {
  CamelotDioBearerAuthInterceptor(super.dio);

  Future<String?> getToken() async {
    return null;
  }

  @override
  Future<bool> setToken(RequestOptions options) async {
    final token = await getToken();
    options.headers['Authorization'] = 'Bearer $token';
    return super.setToken(options);
  }
}
