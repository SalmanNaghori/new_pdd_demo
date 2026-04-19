import 'package:new_pdd_demo/core/network/api/api_constants.dart';
import 'package:new_pdd_demo/core/network/client/dio_client.dart';
import 'package:new_pdd_demo/core/network/models/request_model.dart';
import 'package:new_pdd_demo/feature/auth/data/models/user_auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserAuthModel> login({required String email, required String password});

  Future<UserAuthModel> signup({
    required String name,
    required String email,
    required String password,
  });
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient apiClient;

  AuthRemoteDataSourceImpl(this.apiClient);

  @override
  Future<UserAuthModel> login({required String email, required String password}) async {
    final response = await apiClient.request(
      request: RequestModel(
        method: HTTPMethod.post,
        endpoint: ApiConstants.login,
        data: {"username": email, "password": password},
      ),
    );

    return UserAuthModel.fromJson(response.data, email, password);
  }

  @override
  Future<UserAuthModel> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    final response = await apiClient.request(
      request: RequestModel(
        method: HTTPMethod.post,
        endpoint: ApiConstants.register,
        data: {"email": email, "password": password, "name": name},
      ),
    );

    return UserAuthModel.fromJson(response.data, name, email);
  }
}
