
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/core/constants/string_constant.dart';
import 'package:firebase_demo/core/enums/view_state.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/routing/routes.dart';
import 'package:firebase_demo/core/services/firebase_services.dart';
import 'package:firebase_demo/core/view_models/base_model.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final List<String> gender = ["male", "female"];
  String? select = "male";
  FirebaseServices services = FirebaseServices();

  void onClickRadioButton(value) {
    select = value;
    updateUI();
  }

  final _randomUserId = Random();
  String id = "";
  String getUserId() {
    for (var i = 0; i < 12; i++) {
      id += _randomUserId.nextInt(10).toString();
    }
    return id;
  }
  Future<void> signUp(BuildContext context) async {
    state = ViewState.busy;
    try {
      state = ViewState.idle;
      if (formKey.currentState?.validate() ?? false) {
        state = ViewState.busy;
        UserModel user = UserModel(
            id: getUserId(),
            email: emailController.text,
            gender: select,
            name: nameController.text,
            password: passwordController.text,
            phoneNo: phoneController.text,
            image: "");
        await services.registerUser(user);
        emailController.clear();
        nameController.clear();
        passwordController.clear();
        phoneController.clear();
        state = ViewState.idle;
        if(context.mounted){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(StringConstants.successSignUp)));
        Navigator.pushReplacementNamed(context, Routes.signInScreen,
                    arguments: user);}
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(StringConstants.fillSignUpDetails)));
      }
    } on FirebaseException catch (e) {
      if(context.mounted){
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.toString())));}
    }
  }
}
