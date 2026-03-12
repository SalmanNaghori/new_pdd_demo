import 'package:dartz/dartz.dart';
import '../../../../core/error/failure.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';

class LoginUser {
  final AuthRepository repository;

  LoginUser(this.repository);

  Future<Either<Failure, User>> call({required String email, required String password}) async {
    // 🔥 Example business validation
    if (email.isEmpty || password.isEmpty) {
      return Left(ValidationFailure("Email and Password cannot be empty"));
    }

    // if (!email.contains("@")) {
    //   return Left(ValidationFailure("Invalid email format"));
    // }

    return await repository.login(email: email, password: password);
  }
}
