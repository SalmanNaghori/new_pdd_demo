import 'package:dio/dio.dart';
import 'package:new_pdd_demo/core/routes/app_router.dart';
import 'package:new_pdd_demo/core/storage/local_storage_service.dart';

class AppInterceptor extends Interceptor {
  final LocalStorageService localStorageService;

  AppInterceptor({required this.localStorageService});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Check if the request is marked as private
    bool isPrivate = options.headers['isPrivate'] == 'true';
    
    // Remove the custom flag before sending
    options.headers.remove('isPrivate');

    if (isPrivate) {
      final token = localStorageService.getAuthToken();
      if (token != null && token.isNotEmpty) {
        options.headers['Authorization'] = 'Bearer $token';
      }
    }
    
    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    // Handle 401 Unauthorized globally, EXCLUDING the login endpoint itself
    if (err.response?.statusCode == 401 && !err.requestOptions.path.contains('/login')) {
      // Clear user data
      localStorageService.clearAuthToken();
      // Redirect to login using go_router
      AppRouter.router.go('/login');
    }
    
    super.onError(err, handler);
  }
}

