import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firestore_demo/screens/home_screen.dart';
import 'package:firestore_demo/services/firebase_services.dart';
import 'package:firestore_demo/services/route_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseServices authServices = FirebaseServices();

  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is Login) {
        emit(AuthState(loading: true));

        User? user = await authServices.logIn(event.email, event.password);

        if (user != null) {
          Fluttertoast.showToast(msg: "Login success");
          // ignore: use_build_context_synchronously
          Navigator.pushReplacement(RouteState.currentContext,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          // Fluttertoast.showToast(msg: "invalid user cred");
        }

        emit(AuthState(loading: false));
      }

      if (event is SignUp) {
        emit(AuthState(loading: true));

        User? user = await authServices.signUp(event.email, event.password);

        if (user != null) {
          Fluttertoast.showToast(msg: "Signup success");
          Navigator.pushReplacement(RouteState.currentContext,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
        } else {
          // Fluttertoast.showToast(msg: "something went wrong");
        }

        emit(AuthState(loading: false));
      }
    });
  }
}
