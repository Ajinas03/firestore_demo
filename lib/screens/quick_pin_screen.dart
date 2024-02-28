import 'package:firestore_demo/screens/login_screen.dart';
import 'package:firestore_demo/services/route_service.dart';
import 'package:firestore_demo/services/shared_prefs.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class QuickPin extends StatelessWidget {
  const QuickPin({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController pinEditingController = TextEditingController();

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    (Prefs.getString(SETPIN)?.isEmpty ?? false)
                        ? "Create PIN"
                        : "Enter PIN",
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              inputField(
                hintText: (Prefs.getString(SETPIN)?.isEmpty ?? false)
                    ? "Create PIN"
                    : 'Pin',
                errorMessage: 'Please enter your email',
                textEditingController: pinEditingController,
              ),
              const SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: '',
                  style: const TextStyle(color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'LogIn',
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
              FloatingActionButton.extended(
                  onPressed: () {}, label: const Text("Login"))
            ],
          ),
        ),
      ),
    );
  }
}

class PinHelperClass {
  final context = RouteState.currentContext;
  showAlertDialogue() {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
            contentPadding: EdgeInsets.all(0),
            shape: RoundedRectangleBorder(
              side: BorderSide(color: Colors.purple),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            content: QuickPin());
      },
    );
  }
}
