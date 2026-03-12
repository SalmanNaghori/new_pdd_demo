import 'package:get/get.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/login_user.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/signup_user.dart';

enum AuthStatus { initial, loading, success, error }

class AuthController extends GetxController {
  final LoginUser loginUser;
  final SignupUser signupUser;

  AuthController({required this.loginUser, required this.signupUser});

  var status = AuthStatus.initial.obs;
  var errorMessage = ''.obs;

  Future<void> login(String email, String password) async {
    status.value = AuthStatus.loading;

    final result = await loginUser(email: email, password: password);

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        status.value = AuthStatus.error;
      },
      (user) {
        status.value = AuthStatus.success;
      },
    );
  }

  Future<void> signup(String name, String email, String password) async {
    status.value = AuthStatus.loading;

    final result = await signupUser(name: name, email: email, password: password);

    result.fold(
      (failure) {
        errorMessage.value = failure.message;
        status.value = AuthStatus.error;
      },
      (user) {
        status.value = AuthStatus.success;
      },
    );
  }
}
