import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/services/firebase_api.dart';
import 'package:firebase_demo/core/view_models/base_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  final List<String> gender = ["male", "female"];
  String? select = "male";
  void onClickRadioButton(value) {
    select = value;
    updateUI();
  }

Future<void> signUp(UserModel user) async {
   
      try {
        await FirebaseApi().registerUser(user);
        log("Sign Up Successful");
      } on FirebaseException catch (e) {
        log(e.toString());
      }
    
  }
}
