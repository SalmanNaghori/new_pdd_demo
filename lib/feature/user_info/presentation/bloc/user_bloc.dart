import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pdd_demo/feature/user_info/domain/entities/user.dart';
import 'package:new_pdd_demo/feature/user_info/domain/usecases/get_users.dart';

// EVENTS
abstract class UserEvent {}
class FetchUsersEvent extends UserEvent {}

// STATES
abstract class UserState {}
class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserSuccess extends UserState {
  final List<User> users;
  UserSuccess(this.users);
}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}

// BLOC
class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUsers getUsersUseCase;

  UserBloc({required this.getUsersUseCase}) : super(UserInitial()) {
    on<FetchUsersEvent>((event, emit) async {
      emit(UserLoading());
      final result = await getUsersUseCase();
      result.fold(
        (error) => emit(UserError(error.toString())),
        (data) => emit(UserSuccess(data)),
      );
    });
  }
}
