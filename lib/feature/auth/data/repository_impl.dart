import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:new_pdd_demo/core/error/failure.dart';
import 'package:new_pdd_demo/core/network/network_info.dart';
import 'package:new_pdd_demo/feature/auth/data/datasource/auth_remote_datasource.dart';
import 'package:new_pdd_demo/feature/auth/domain/entities/user.dart';
import 'package:new_pdd_demo/feature/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl(this.remoteDataSource, this.networkInfo);

  @override
  Future<Either<Failure, User>> login({required String password, required String email}) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure("No Internet Connection"));
    }

    try {
      final user = await remoteDataSource.login(email: email, password: password);
      return Right(user);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 400) {
        return Left(AuthFailure(e.response?.data["error"] ?? "Invalid data"));
      }

      if (statusCode == 503) {
        return Left(MaintenanceFailure("Server under maintenance"));
      }

      return Left(ServerFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, User>> signup({required String name, required String email, required String password}) async {
    if (!await networkInfo.isConnected) {
      return Left(NetworkFailure("No Internet Connection"));
    }

    try {
      final user = await remoteDataSource.signup(email: email, password: password, name: name);
      return Right(user);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;

      if (statusCode == 400) {
        return Left(AuthFailure(e.response?.data["error"] ?? "Invalid data"));
      }

      if (statusCode == 503) {
        return Left(MaintenanceFailure("Server under maintenance"));
      }

      return Left(ServerFailure("Something went wrong"));
    }
  }
}
