import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/login_user.dart';
import 'package:new_pdd_demo/feature/auth/domain/usecase/signup_user.dart';

// EVENTS
abstract class AuthEvent {}
class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  LoginRequested(this.email, this.password);
}
class SignupRequested extends AuthEvent {
  final String name;
  final String email;
  final String password;
  SignupRequested(this.name, this.email, this.password);
}

// STATES
abstract class AuthState {}
class AuthInitial extends AuthState {}
class AuthLoading extends AuthState {}
class AuthSuccess extends AuthState {}
class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// BLOC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final SignupUser signupUser;

  AuthBloc({required this.loginUser, required this.signupUser}) : super(AuthInitial()) {
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await loginUser(email: event.email, password: event.password);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthSuccess()),
      );
    });

    on<SignupRequested>((event, emit) async {
      emit(AuthLoading());
      final result = await signupUser(name: event.name, email: event.email, password: event.password);
      result.fold(
        (failure) => emit(AuthError(failure.message)),
        (user) => emit(AuthSuccess()),
      );
    });
  }
}
