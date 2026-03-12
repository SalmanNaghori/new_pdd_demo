import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:new_pdd_demo/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:new_pdd_demo/feature/auth/data/repository_impl.dart';
import 'package:new_pdd_demo/feature/auth/domain/repositories/auth_repository.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/login_user.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/signup_user.dart';
import 'package:new_pdd_demo/feature/auth/presentation/controller/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(Get.find()));

    Get.lazyPut<AuthRepository>(() => AuthRepositoryImpl(Get.find(), Get.find()));

    Get.lazyPut<LoginUser>(() => LoginUser(Get.find()));
    Get.lazyPut<SignupUser>(() => SignupUser(Get.find()));

    Get.lazyPut<AuthController>(() => AuthController(loginUser: Get.find(), signupUser: Get.find()));
  }
}
