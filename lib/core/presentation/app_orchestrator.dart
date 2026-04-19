import 'package:flutter/material.dart';
import 'package:new_pdd_demo/core/network/monitor/network_monitor.dart';
import 'package:new_pdd_demo/core/di/injection.dart';

class AppOrchestrator extends StatefulWidget {
  final Widget child;
  const AppOrchestrator({super.key, required this.child});

  @override
  State<AppOrchestrator> createState() => _AppOrchestratorState();
}

class _AppOrchestratorState extends State<AppOrchestrator> {
  bool isOffline = false;

  @override
  void initState() {
    super.initState();
    // Start listening to the network
    final networkMonitor = sl<NetworkMonitor>();
    
    // Check initial synchronously if we want, or just rely on stream
    networkMonitor.isConnected.then((connected) {
      if (mounted) setState(() { isOffline = !connected; });
    });

    networkMonitor.onNetworkStatusChanged.listen((isOnline) {
      if (mounted) {
        setState(() {
          isOffline = !isOnline;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Stack(
        children: [
          widget.child,
          if (isOffline)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Material(
                color: Colors.redAccent,
                elevation: 10,
                child: SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.cloud_off, color: Colors.white),
                        SizedBox(width: 12),
                        Text(
                          "No Internet Connection",
                          style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
