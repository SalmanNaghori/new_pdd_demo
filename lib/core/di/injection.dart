import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:new_pdd_demo/feature/user_info/domain/repositories/user_repository.dart';

import '../../feature/user_info/data/datasource/user_remote_datasource.dart';
import '../../feature/user_info/data/repository_impl.dart';
import '../../feature/user_info/domain/usecases/get_users.dart';
import '../../feature/user_info/presentation/controller/user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    // Dio (single instance)
    Get.lazyPut<Dio>(() => Dio(BaseOptions(headers: {"Accept": "application/json", "User-Agent": "FlutterApp"})));

    // DataSource
    Get.lazyPut<UserRemoteDataSource>(() => UserRemoteDataSource(Get.find()));

    // Repository
    Get.lazyPut<UserRepository>(() => UserRepositoryImpl(Get.find()));

    // UseCase
    Get.lazyPut<GetUsers>(() => GetUsers(Get.find()));

    // Controller
    Get.lazyPut<UserController>(() => UserController(Get.find()));
  }
}
