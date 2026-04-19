import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:new_pdd_demo/core/network/interceptors/app_interceptor.dart';
import 'package:new_pdd_demo/core/network/interceptors/retry_interceptor.dart';
import 'package:new_pdd_demo/core/network/client/dio_client.dart';
import 'package:new_pdd_demo/core/network/monitor/network_info.dart';
import 'package:new_pdd_demo/core/network/monitor/network_monitor.dart';
import 'package:new_pdd_demo/core/theme/bloc/theme_bloc.dart';
import 'package:new_pdd_demo/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:new_pdd_demo/feature/auth/data/repository_impl.dart';
import 'package:new_pdd_demo/feature/auth/domain/repositories/auth_repository.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/login_user.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/signup_user.dart';
import 'package:new_pdd_demo/feature/auth/presentation/bloc/auth_bloc.dart';

import 'package:new_pdd_demo/feature/user_info/data/datasource/user_remote_datasource.dart';
import 'package:new_pdd_demo/feature/user_info/data/repository_impl.dart';
import 'package:new_pdd_demo/feature/user_info/domain/repositories/user_repository.dart';
import 'package:new_pdd_demo/feature/user_info/domain/usecases/get_users.dart';
import 'package:new_pdd_demo/feature/user_info/presentation/bloc/user_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:dio/dio.dart';
import 'package:new_pdd_demo/core/network/client/dio_factory.dart';
import 'package:new_pdd_demo/core/storage/local_storage_service.dart';

final sl = GetIt.instance; // sl stands for Service Locator

Future<void> initInjector() async {
  // Core Plugins
  final sharedPreferences = await SharedPreferences.getInstance();

  // Storage Wrapper
  sl.registerLazySingleton(() => LocalStorageService(sharedPreferences));

  sl.registerLazySingleton(() => Connectivity());
  sl.registerFactory(() => ThemeBloc(localStorageService: sl()));

  // Interceptors & Network Logic
  sl.registerLazySingleton(() => NetworkInfo(sl()));
  sl.registerLazySingleton(() => NetworkMonitor(connectivity: sl()));

  sl.registerLazySingleton(() => AppInterceptor(localStorageService: sl()));
  sl.registerLazySingleton(() => RetryInterceptor(networkMonitor: sl()));

  // Dio Registration
  sl.registerLazySingleton<Dio>(
    () => DioFactory.createDio(appInterceptor: sl(), retryInterceptor: sl()),
  );

  // ApiClient setup
  sl.registerLazySingleton(() => ApiClient(dio: sl()));

  // Feature: Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl(), sl()));
  sl.registerLazySingleton(() => LoginUser(sl()));
  sl.registerLazySingleton(() => SignupUser(sl()));
  sl.registerFactory(() => AuthBloc(loginUser: sl(), signupUser: sl()));

  // Feature: User Info
  sl.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource(sl()));
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetUsers(sl()));
  sl.registerFactory(() => UserBloc(getUsersUseCase: sl()));
}
