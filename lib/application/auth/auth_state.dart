part of 'auth_bloc.dart';

class AuthState {
  bool loading;
  AuthState({required this.loading});
}

class AuthInitial extends AuthState {
  AuthInitial() : super(loading: false);
}
