import 'package:go_router/go_router.dart';
import 'package:new_pdd_demo/feature/auth/presentation/pages/login_screen.dart';
import 'package:new_pdd_demo/feature/auth/presentation/pages/signup_screen.dart';
import 'package:new_pdd_demo/feature/user_info/presentation/pages/user_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignupScreen(),
      ),
      GoRoute(
        path: '/users',
        builder: (context, state) => UserScreen(),
      ),
    ],
  );
}
