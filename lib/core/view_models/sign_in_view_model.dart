import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/routing/routes.dart';
import 'package:firebase_demo/core/services/firebase_services.dart';
import 'package:firebase_demo/core/view_models/base_model.dart';
import 'package:flutter/material.dart';

class SignInViewModel extends BaseModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FirebaseServices services = FirebaseServices();

  Future<void> signIn(BuildContext context, String id, UserModel model) async {
    try {
      final user = await services.checkCredentials(id);
      if (user.email == emailController.text &&
          user.password == passwordController.text) {
            if(context.mounted){
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Logged In")));
        Navigator.pushReplacementNamed(context, Routes.updateScreen, arguments: user);}
      } else {
        if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Please enter correct email and password")));}
      }
    } catch (e) {
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Log In Failed${e.toString()}")));}
    }
  }
}
