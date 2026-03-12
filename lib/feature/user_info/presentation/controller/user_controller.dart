import 'package:get/get.dart';
import 'package:new_pdd_demo/feature/user_info/domain/entities/user.dart';
import 'package:new_pdd_demo/feature/user_info/domain/usecases/get_users.dart';

enum Status { initial, loading, success, error }

class UserController extends GetxController {
  final GetUsers getUsersUseCase;

  UserController(this.getUsersUseCase);

  var status = Status.initial.obs;
  var users = <User>[].obs;
  var errorMessage = ''.obs;

  @override
  void onInit() {
    fetchUsers();
    super.onInit();
  }

  Future<void> fetchUsers() async {
    status.value = Status.loading;

    final result = await getUsersUseCase();

    result.fold(
      (error) {
        errorMessage.value = error;
        status.value = Status.error;
      },
      (data) {
        users.value = data;
        status.value = Status.success;
      },
    );
  }
}
