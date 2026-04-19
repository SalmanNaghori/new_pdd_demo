import 'package:dio/dio.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  factory ApiException.fromDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ApiException(message: "Connection timed out. Please try again later.");
      case DioExceptionType.badResponse:
        return ApiException(
          message: _handleBadResponse(exception.response?.statusCode, exception.response?.data),
          statusCode: exception.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiException(message: "Request was cancelled.");
      case DioExceptionType.connectionError:
        return ApiException(message: "No Internet Connection.");
      case DioExceptionType.unknown:
      default:
        return ApiException(message: "An unexpected error occurred.");
    }
  }

  static String _handleBadResponse(int? statusCode, dynamic data) {
    if (data is Map && data.containsKey('message')) {
      return data['message'];
    }
    switch (statusCode) {
      case 400: return "Bad Request";
      case 401: return "Unauthorized";
      case 403: return "Forbidden";
      case 404: return "Resource not found";
      case 500: return "Internal server error";
      default: return "Oops! Something went wrong";
    }
  }
}
