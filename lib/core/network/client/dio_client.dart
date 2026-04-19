import 'package:dio/dio.dart';
import 'package:new_pdd_demo/core/network/models/request_model.dart';
import 'package:new_pdd_demo/core/network/api/api_constants.dart';
import 'package:new_pdd_demo/core/network/error/api_exception.dart';

class ApiClient {
  final Dio _dio;

  ApiClient({required Dio dio}) : _dio = dio;
  
  /// Master Single Request Method
  Future<Response> request({required RequestModel request}) async {
    // Dynamically assign Base URL based on private/public scoping or explicit overrides
    String baseUrl = request.baseUrlOverride ?? 
        (request.isPrivate ? ApiConstants.privateBaseUrl : ApiConstants.publicBaseUrl);

    dynamic bodyData = request.formData ?? request.data;
    
    Map<String, dynamic> requestHeaders = {
      ...request.headers ?? {},
      ..._dio.options.headers, // ensure default headers pass cleanly
      "isPrivate": request.isPrivate.toString(),
    };

    try {
      final options = Options(
        method: request.method.name.toUpperCase(),
        headers: requestHeaders,
      );

      final response = await _dio.request(
        '$baseUrl${request.endpoint}',
        data: bodyData,
        queryParameters: request.queryParameters,
        options: options,
      );
      
      return response;
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    } catch (e) {
      throw ApiException(message: e.toString());
    }
  }
}
