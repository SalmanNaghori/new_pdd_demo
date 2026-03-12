import 'package:dio/dio.dart';
import 'package:new_pdd_demo/feature/auth/data/models/user_auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthModel> login({required String email, required String password});

  Future<UserAuthModel> signup({required String name, required String email, required String password});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<UserAuthModel> login({required String email, required String password}) async {
    final response = await dio.post('/auth/login', data: {"username": email, "password": password});

    if (response.statusCode == 200) {
      return UserAuthModel.fromJson(response.data, email, password);
    } else {
      throw DioException(requestOptions: response.requestOptions, response: response);
    }
  }

  @override
  Future<UserAuthModel> signup({required String name, required String email, required String password}) async {
    final response = await dio.post('https://reqres.in/api/register', data: {"email": email, "password": password});

    if (response.statusCode == 200) {
      return UserAuthModel.fromJson(response.data, name, email);
    } else {
      throw DioException(requestOptions: response.requestOptions, response: response);
    }
  }
}
