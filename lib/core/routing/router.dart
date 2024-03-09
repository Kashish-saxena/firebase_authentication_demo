import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/routing/routes.dart';
import 'package:firebase_demo/ui/views/sign_in_screen.dart';
import 'package:firebase_demo/ui/views/sign_up_screen.dart';
import 'package:firebase_demo/ui/views/update_screen.dart';
import 'package:flutter/material.dart';

class PageRoutes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (context) => SignUpScreen());
      case Routes.signInScreen:
        UserModel userDetail = settings.arguments as UserModel;
        return MaterialPageRoute(builder: (context) => SignInScreen(userDetail:userDetail));
      case Routes.updateScreen:
        UserModel userDetail = settings.arguments as UserModel;
        return MaterialPageRoute(
            builder: (context) => UpdateScreen(userDetail: userDetail));
      default:
        return MaterialPageRoute(
            builder: (context) => const Text("No Page exists..."));
    }
  }
}
