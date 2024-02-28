import 'package:firestore_demo/application/auth/auth_bloc.dart';
import 'package:firestore_demo/screens/login_screen.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController userNameEditingController = TextEditingController();

    TextEditingController emailEditingController = TextEditingController();
    TextEditingController passwordEditingController = TextEditingController();
    TextEditingController confirmPasswordEditingController =
        TextEditingController();

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
                hintText: 'username',
                errorMessage: 'Please enter your email',
                textEditingController: userNameEditingController,
              ),
              const SizedBox(height: 20),
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
              const SizedBox(height: 20),
              inputField(
                hintText: 'confirm password',
                errorMessage: 'Please enter your password',
                textEditingController: confirmPasswordEditingController,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'have an account? ',
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Log in',
                      style: const TextStyle(color: Colors.blue),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          HapticFeedback.lightImpact();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginScreen()));
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
                            context.read<AuthBloc>().add(SignUp(
                                email: emailEditingController.text,
                                password: passwordEditingController.text));
                          },
                          label: const Text("Sign up"));
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
