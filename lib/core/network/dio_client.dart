import 'package:dio/dio.dart';
import 'package:new_pdd_demo/core/network/auth_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  static Dio createDio(Future<String?> Function() getToken) {
    final dio = Dio(
      BaseOptions(
        baseUrl: "https://dummyjson.com",
        connectTimeout: const Duration(seconds: 60),
        receiveTimeout: const Duration(seconds: 10),
        headers: {"Accept": "application/json", "Content-Type": "application/json"},
      ),
    );

    dio.interceptors.add(AuthInterceptor(getToken: getToken));

    // 🔥 Add Pretty Logger
    dio.interceptors.add(PrettyDioLogger(requestHeader: true, requestBody: true, responseBody: true, responseHeader: false, error: true, compact: true, maxWidth: 90));

    return dio;
  }
}
