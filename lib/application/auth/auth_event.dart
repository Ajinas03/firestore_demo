part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

// ignore: must_be_immutable
class Login extends AuthEvent {
  Login({required this.email, required this.password});
  String email;
  String password;
}

// ignore: must_be_immutable
class SignUp extends AuthEvent {
  SignUp({required this.email, required this.password});
  String email;
  String password;
}
