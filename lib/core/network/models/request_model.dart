import 'package:dio/dio.dart';

enum HTTPMethod { get, post, put, delete, patch }

class RequestModel {
  final HTTPMethod method;
  final String endpoint;
  final Map<String, dynamic>? queryParameters;
  final Map<String, dynamic>? data;
  final Map<String, dynamic>? headers;
  final FormData? formData;
  final String? baseUrlOverride;
  final bool isPrivate;

  RequestModel({
    required this.method,
    required this.endpoint,
    this.queryParameters,
    this.data,
    this.headers,
    this.formData,
    this.baseUrlOverride,
    this.isPrivate = true,
  });
}
