import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/error/failure.dart';

class SignupUser {
  final AuthRepository repository;

  SignupUser(this.repository);

  Future<Either<Failure, User>> call({required String name, required String email, required String password}) async {
    if (name.isEmpty) {
      return Left(ValidationFailure("Name is required"));
    }

    if (password.length < 6) {
      return Left(ValidationFailure("Password must be at least 6 characters"));
    }

    return await repository.signup(name: name, email: email, password: password);
  }
}
