import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkMonitor {
  final Connectivity _connectivity;
  final StreamController<bool> _networkStatusController = StreamController<bool>.broadcast();

  NetworkMonitor({required Connectivity connectivity}) : _connectivity = connectivity {
    _initMonitor();
  }

  Stream<bool> get onNetworkStatusChanged => _networkStatusController.stream;

  Future<void> _initMonitor() async {
    // Check initial status
    List<ConnectivityResult> results = await _connectivity.checkConnectivity();
    _updateStatus(results);

    // Listen for changes
    _connectivity.onConnectivityChanged.listen((List<ConnectivityResult> results) {
      _updateStatus(results);
    });
  }

  void _updateStatus(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none) || results.isEmpty) {
      _networkStatusController.add(false); // Offline
    } else {
      _networkStatusController.add(true); // Online
    }
  }

  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return !results.contains(ConnectivityResult.none) && results.isNotEmpty;
  }
}
