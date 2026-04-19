import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pdd_demo/core/di/injection.dart';
import 'package:new_pdd_demo/core/routes/app_router.dart';
import 'package:new_pdd_demo/core/presentation/app_orchestrator.dart';
import 'package:new_pdd_demo/core/theme/app_theme.dart';
import 'package:new_pdd_demo/core/theme/bloc/theme_bloc.dart';
import 'package:new_pdd_demo/core/constant/app_strings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initInjector();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ThemeBloc>()..add(LoadThemeEvent()),
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          return MaterialApp.router(
            title: AppStrings.appName,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state.themeMode,
            builder: (context, child) => AppOrchestrator(child: child!),
            routerConfig: AppRouter.router,
          );
        },
      ),
    );
  }
}
