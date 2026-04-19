import 'package:dartz/dartz.dart';
import 'package:new_pdd_demo/core/network/error/api_exception.dart';
import 'package:new_pdd_demo/core/error/failure.dart';
import 'package:new_pdd_demo/core/network/monitor/network_info.dart';
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
    } on ApiException catch (e) {
      if (e.statusCode == 400 || e.statusCode == 401) {
        return Left(AuthFailure(e.message)); // Uses our global parsing
      }

      if (e.statusCode == 503) {
        return Left(MaintenanceFailure("Server under maintenance"));
      }

      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Unexpected error occurred"));
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
    } on ApiException catch (e) {
      if (e.statusCode == 400) {
        return Left(AuthFailure(e.message));
      }

      if (e.statusCode == 503) {
        return Left(MaintenanceFailure("Server under maintenance"));
      }

      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure("Unexpected error occurred"));
    }
  }
}
