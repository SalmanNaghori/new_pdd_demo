import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Signup")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.status.value == AuthStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(labelText: "Email"),
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.signup(nameController.text, emailController.text, passwordController.text);
                },
                child: const Text("Signup"),
              ),
              if (controller.status.value == AuthStatus.error) Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)),
            ],
          );
        }),
      ),
    );
  }
}
