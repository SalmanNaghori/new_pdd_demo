import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    emailController.text='eve.holt@reqres.in';
    passwordController.text='cityslicka';
    final controller = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (controller.status.value == AuthStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            children: [
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
                  controller.login(emailController.text, passwordController.text);
                },
                child: const Text("Login"),
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed('/signup');
                },
                child: const Text("Go to Signup"),
              ),
              if (controller.status.value == AuthStatus.error) Text(controller.errorMessage.value, style: const TextStyle(color: Colors.red)),
            ],
          );
        }),
      ),
    );
  }
}
