import 'package:dio/dio.dart';
import 'package:new_pdd_demo/feature/user_info/data/model/user_model.dart';

class UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSource(this.dio);

  Future<List<UserModel>> getUsers() async {
    final response = await dio.get('https://jsonplaceholder.typicode.com/users', options: Options(validateStatus: (status) => true));

    if (response.statusCode == 200) {
      return (response.data as List).map((json) => UserModel.fromJson(json)).toList();
    } else {
      throw Exception("Server error: ${response.statusCode}");
    }
  }
}
