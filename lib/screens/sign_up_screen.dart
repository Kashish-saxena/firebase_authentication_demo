import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_demo/utils/validations.dart';
import 'package:firebase_demo/widgets/alert_dialog.dart';
import 'package:firebase_demo/widgets/elevated_button.dart';
import 'package:firebase_demo/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: buildBody(context),
    ));
  }

  Widget buildBody(context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    signUp(String email, String password) async {
      if (email.isEmpty || password.isEmpty) {
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialogWidget(text: "Please enter email and password");
          },
        );
      } else {
        UserCredential? userCredential;
        try {
          userCredential = await FirebaseAuth.instance
              .createUserWithEmailAndPassword(email: email, password: password)
              .then((value) => showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialogWidget(
                          text: "Sign Up Successful");
                    },
                  ));
        } on FirebaseAuthException catch (e) {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialogWidget(text: e.code.toString());
              });
        }
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextFormFieldWidget(
          labelText: "Email",
          obscureText: false,
          controller: emailController,
          validator: (email) {
            return Validations.isEmailValid(email);
          },
        ),
        TextFormFieldWidget(
          labelText: "Password",
          obscureText: true,
          controller: passwordController,
          validator: (password) {
            return Validations.isPasswordValid(password);
          },
        ),
        ElevatedButtonWidget(
          onPressed: () {
            signUp(emailController.text.toString(),
                passwordController.text.toString());
          },
          text: "Sign Up",
        ),
      ],
    );
  }
}
