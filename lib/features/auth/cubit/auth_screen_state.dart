part of 'auth_screen_cubit.dart';

@immutable
abstract class AuthScreenState {}

class AuthScreenInitial extends AuthScreenState {}

class AuthScreenChange extends AuthScreenState {}

class RegisterLoading extends AuthScreenState {}

class RegisterSuccess extends AuthScreenState {}

class RegisterFailure extends AuthScreenState {
 final String err;
  RegisterFailure({required this.err});
}

class LoginLoading extends AuthScreenState {}

class LoginSuccess extends AuthScreenState {}

class LoginFailure extends AuthScreenState {
  final String err;
  LoginFailure({required this.err});
}

class UserDataLoading extends AuthScreenState {}

class UserDataLoaded extends AuthScreenState {
  final User user;

  UserDataLoaded(this.user);
}

class UserDataError extends AuthScreenState {}

class AuthScreenLoggedIn extends AuthScreenState {}

class AuthScreenLoggedOut extends AuthScreenState {}
