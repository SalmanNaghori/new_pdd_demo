import 'dart:async';
import 'dart:collection';
import 'package:dio/dio.dart';
import 'package:new_pdd_demo/core/di/injection.dart';
import 'package:new_pdd_demo/core/network/monitor/network_monitor.dart';

class RetryInterceptor extends Interceptor {
  final NetworkMonitor networkMonitor;
  
  // A queue to hold pending requests
  final Queue<Map<String, dynamic>> _failedRequestsQueue = Queue();
  bool _isListeningToNetwork = false;

  RetryInterceptor({required this.networkMonitor}) {
    _startNetworkListener();
  }

  void _startNetworkListener() {
    if (_isListeningToNetwork) return;
    _isListeningToNetwork = true;
    
    networkMonitor.onNetworkStatusChanged.listen((isOnline) {
      if (isOnline) {
        _retryFailedRequests();
      }
    });
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (_shouldRetry(err)) {
      // Add to queue
      _failedRequestsQueue.add({
        'options': err.requestOptions,
        'handler': handler,
      });
      // Do not call super.onError here yet, we are holding the request.
      // But we should notify the UI if we want to. Let's just hold it.
    } else {
      super.onError(err, handler);
    }
  }

  bool _shouldRetry(DioException err) {
    return err.type == DioExceptionType.connectionTimeout ||
           err.type == DioExceptionType.sendTimeout ||
           err.type == DioExceptionType.receiveTimeout ||
           err.type == DioExceptionType.connectionError;
  }

  Future<void> _retryFailedRequests() async {
    while (_failedRequestsQueue.isNotEmpty) {
      final requestItem = _failedRequestsQueue.removeFirst();
      final RequestOptions options = requestItem['options'];
      final ErrorInterceptorHandler handler = requestItem['handler'];

      try {
        // Clone the request to re-fire it using lazy DI resolution to avoid circular scopes
        final response = await sl<Dio>().fetch(options);
        handler.resolve(response);
      } on DioException catch (e) {
        handler.reject(e);
      }
    }
  }
}
