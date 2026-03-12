import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/user_controller.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UserController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Users")),
      body: Obx(() {
        switch (controller.status.value) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());

          case Status.error:
            return Center(child: Text(controller.errorMessage.value));

          case Status.success:
            return ListView.builder(
              itemCount: controller.users.length,
              itemBuilder: (context, index) {
                final user = controller.users[index];
                return ListTile(title: Text(user.name), subtitle: Text(user.email));
              },
            );

          default:
            return const SizedBox();
        }
      }),
    );
  }
}
