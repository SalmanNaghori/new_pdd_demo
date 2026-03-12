import 'package:new_pdd_demo/feature/auth/domain/entities/user.dart';

class UserAuthModel extends User {
  UserAuthModel({required super.id, required super.name, required super.email, required super.token});

  factory UserAuthModel.fromJson(Map<String, dynamic> json, String name, String email) {
    return UserAuthModel(
      id: json['id'].toString(),
      name: name, // from parameter
      email: email, // from parameter
      token: json['token'],
    );
  }
}
