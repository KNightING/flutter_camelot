import 'package:dio/dio.dart';
import 'package:flutter_camelot/dio_extend.dart';

/// need dependencies dio
class ExampleApiService extends CamelotDioService {
  static ExampleApiService instance = ExampleApiService._();

  factory ExampleApiService() {
    return instance;
  }

  ExampleApiService._()
      : super(
            options: BaseOptions(
              baseUrl: 'http://localhost:5273/',
              connectTimeout: const Duration(seconds: 10),
              receiveTimeout: const Duration(seconds: 30),
            ),
            camelotDioOptions: CamelotDioOptions(
              writeCamelotLog: false,
            ));

  ResponseParse<String> errorResponseParse = (Response response) {
    return 'response status code: ${response.statusCode}';
  };

  Future<CamelotDioResponse> getTest() {
    return get(
      '/test',
      parse: (response) => response.data.toString(),
      errorParse: errorResponseParse,
    );
  }

  Future<CamelotDioResponse> postTest() {
    return post(
      '/test',
      parse: (response) => response.data.toString(),
      errorParse: errorResponseParse,
    );
  }

  Future<CamelotDioResponse> patchTest() {
    return patch(
      '/test',
      parse: (response) => response.data.toString(),
      errorParse: errorResponseParse,
    );
  }

  Future<CamelotDioResponse> putTest() {
    return put(
      '/test',
      parse: (response) => response.data.toString(),
      errorParse: errorResponseParse,
    );
  }

  Future<CamelotDioResponse> deleteTest() {
    return delete(
      '/test',
      parse: (response) => response.data.toString(),
      errorParse: errorResponseParse,
    );
  }

// Future<CamelotDioResponse<TestObj>> statusCode(int code) {
//   return get(
//     '/test/$code',
//     parse: (response) => TestObj.fromJson(response.data),
//     errorParse: errorResponseParse,
//   );
// }
}
