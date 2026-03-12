import 'package:dartz/dartz.dart';
import 'package:new_pdd_demo/feature/user_info/domain/entities/user.dart';
import 'package:new_pdd_demo/feature/user_info/domain/repositories/user_repository.dart';

import 'datasource/user_remote_datasource.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<String, List<User>>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return Right(users);

    } catch (e) {
      print("API ERROR: $e"); // 👈 Add this
      return Left("Failed to fetch users");
    }
  }
}
