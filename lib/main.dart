import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:new_pdd_demo/core/di/auth_binding.dart';
import 'package:new_pdd_demo/core/di/core_binding.dart';
import 'package:new_pdd_demo/feature/auth/presentation/pages/login_screen.dart';
import 'package:new_pdd_demo/feature/auth/presentation/pages/signup_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: CoreBinding(),
      initialRoute: '/login',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen(), binding: AuthBinding()),
        GetPage(name: '/signup', page: () => SignupScreen(), binding: AuthBinding()),
      ],
    );
  }
}
