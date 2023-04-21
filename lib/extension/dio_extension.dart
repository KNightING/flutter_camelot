import 'package:dio/dio.dart';

extension DioResponseExtension on Response {
  bool get isSuccessful {
    final code = statusCode;
    return code != null && code >= 200 && code < 300;
  }

  bool get isRequestError {
    final code = statusCode;
    return code != null && code >= 400 && code < 500;
  }

  bool get isFound {
    return statusCode == 302;
  }

  bool get isBadRequest {
    return statusCode == 400;
  }

  bool get isUnauthorized {
    return statusCode == 401;
  }

  bool get isMethodNotAllow {
    return statusCode == 405;
  }

  bool get isRequestTimeout {
    return statusCode == 408;
  }

  bool get isServerSideError {
    final code = statusCode;
    return code != null && code >= 500 && code < 600;
  }

  bool get isInternalServerError{
    return statusCode == 500;
  }

  bool get isBadGateway{
    return statusCode == 502;
  }
}
