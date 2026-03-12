import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/user_repository.dart';

class GetUsers {
  final UserRepository repository;

  GetUsers(this.repository);

  Future<Either<String, List<User>>> call() {
    return repository.getUsers();
  }
}