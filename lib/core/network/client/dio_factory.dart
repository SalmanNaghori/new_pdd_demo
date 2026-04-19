import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:new_pdd_demo/core/network/interceptors/app_interceptor.dart';
import 'package:new_pdd_demo/core/network/interceptors/retry_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioFactory {
  static Dio createDio({
    required AppInterceptor appInterceptor,
    required RetryInterceptor retryInterceptor,
  }) {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
        },
      ),
    );

    // Apply the custom HTTP Adapter configurations
    dio.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final client = HttpClient();
        client.maxConnectionsPerHost = 6;
        client.autoUncompress = true;
        client.idleTimeout = const Duration(seconds: 3);
        return client;
      },
    );

    // Attach Interceptors at Factory Level
    dio.interceptors.add(appInterceptor);
    dio.interceptors.add(retryInterceptor);
    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
      error: true,
      compact: true,
      maxWidth: 90,
    ));

    return dio;
  }
}
