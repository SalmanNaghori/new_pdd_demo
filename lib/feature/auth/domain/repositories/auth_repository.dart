import 'package:dartz/dartz.dart';
import 'package:new_pdd_demo/core/error/failure.dart';
import 'package:new_pdd_demo/feature/auth/domain/entities/user.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> login({required String email, required String password});

  Future<Either<Failure, User>> signup({required String name, required String email, required String password});
}
