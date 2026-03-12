import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:new_pdd_demo/core/network/network_info.dart';
import '../network/dio_client.dart';
import '../storage/token_storage.dart';

class CoreBinding extends Bindings {
  @override
  void dependencies() {
    // Token Storage
    Get.put<TokenStorage>(TokenStorage(), permanent: true);
    // Network Info
    Get.put<NetworkInfo>(NetworkInfo(Connectivity()), permanent: true);

    Get.put<Dio>(DioClient.createDio(() => Get.find<TokenStorage>().getToken()), permanent: true);
  }
}
