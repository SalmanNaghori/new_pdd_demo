import 'package:new_pdd_demo/core/network/client/dio_client.dart';
import 'package:new_pdd_demo/core/network/error/api_exception.dart';
import 'package:new_pdd_demo/core/network/models/request_model.dart';
import 'package:new_pdd_demo/feature/user_info/data/model/user_model.dart';

class UserRemoteDataSource {
  final ApiClient apiClient;

  UserRemoteDataSource(this.apiClient);

  Future<List<UserModel>> getUsers() async {
    final response = await apiClient.request(
      request: RequestModel(
        method: HTTPMethod.get,
        endpoint: '/users',
        baseUrlOverride: 'https://jsonplaceholder.typicode.com',
        isPrivate: true, // Example showing private call if needed
      ),
    );

    return (response.data as List).map((json) => UserModel.fromJson(json)).toList();
  }
}

