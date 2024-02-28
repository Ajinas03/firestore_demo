import 'package:firestore_demo/application/auth/auth_bloc.dart';
import 'package:firestore_demo/screens/signup_screen.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailEditingController = TextEditingController();
    TextEditingController passwordEditingController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              inputField(
                hintText: 'Email',
                errorMessage: 'Please enter your email',
                textEditingController: emailEditingController,
              ),
              const SizedBox(height: 20),
              inputField(
                hintText: 'Password',
                errorMessage: 'Please enter your password',
                textEditingController: passwordEditingController,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'Don\'t have an account? ',
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Sign up',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignupScreen()));
                          print("Sign up tapped");
                        },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  return state.loading
                      ? const CircularProgressIndicator()
                      : FloatingActionButton.extended(
                          onPressed: () {
                            context.read<AuthBloc>().add(Login(
                                email: emailEditingController.text,
                                password: passwordEditingController.text));
                          },
                          label: const Text("Login"));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

Widget inputField({
  required String hintText,
  required String errorMessage,
  required TextEditingController textEditingController,
}) {
  return TextFormField(
    controller: textEditingController,
    decoration: InputDecoration(
      hintText: hintText,
      suffixIcon: null,
    ),
    validator: (value) {
      if (value == null || value.isEmpty) {
        return errorMessage;
      }
      return null;
    },
  );
}
