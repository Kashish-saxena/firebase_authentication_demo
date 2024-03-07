import 'dart:developer';

import 'package:firebase_demo/core/constants/color_consant.dart';
import 'package:firebase_demo/core/constants/string_constant.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/utils/validations.dart';
import 'package:firebase_demo/core/view_models/signup_view_model.dart';
import 'package:firebase_demo/ui/widgets/elevated_button.dart';
import 'package:firebase_demo/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final provider = Provider.of<SignUpViewModel>(context);

    return Scaffold(
      body: buildBody(deviceHeight, deviceWidth, provider, formKey),
    );
  }

  Widget buildBody(deviceHeight, deviceWidth, provider, formKey) {
    return SingleChildScrollView(
      child: Container(
        height: deviceHeight,
        padding: const EdgeInsets.all(0),
        child: Stack(
          children: [
            Positioned(
              height: deviceHeight * .3,
              width: deviceWidth,
              child: Container(
                color: ColorConstants.black,
                child: Container(
                  alignment: Alignment.center,
                  child: const Text(StringConstants.signUp,
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
              ),
            ),
            Positioned(
              top: deviceHeight * 0.2,
              width: deviceWidth,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 40),
                height: deviceHeight * .9,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
                  color: ColorConstants.white,
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextFormFieldWidget(
                        labelText: StringConstants.name,
                        obscureText: false,
                        controller: provider.nameController,
                        validator: (name) {
                          return Validations.isNameValid(name);
                        },
                      ),
                      TextFormFieldWidget(
                        labelText: StringConstants.email,
                        obscureText: false,
                        controller: provider.emailController,
                        validator: (email) {
                          return Validations.isEmailValid(email);
                        },
                      ),
                      TextFormFieldWidget(
                        labelText: StringConstants.phone,
                        obscureText: false,
                        controller: provider.phoneController,
                        validator: (phone) {
                          return Validations.isPhoneNoValid(phone);
                        },
                      ),
                      TextFormFieldWidget(
                        labelText: StringConstants.password,
                        obscureText: true,
                        controller: provider.passwordController,
                        validator: (password) {
                          return Validations.isPasswordValid(password);
                        },
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 5),
                        decoration: BoxDecoration(
                          border: Border.all(width: 1),
                          borderRadius: BorderRadius.circular(10),
                          color: ColorConstants.white,
                          
                        ),
                        margin: const EdgeInsets.symmetric(vertical: 12),
                        child: Row(
                          children: [
                            const Flexible(
                              child: Text(
                                StringConstants.gender,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xff8391A1),
                                ),
                              ),
                            ),
                            const Spacer(),
                            Radio(
                              activeColor: Colors.blue,
                              value: provider.gender[0],
                              groupValue: provider.select,
                              onChanged: (value) =>
                                  provider.onClickRadioButton(value),
                            ),
                            const Text(StringConstants.male),
                            Radio(
                              activeColor: Colors.blue,
                              value: provider.gender[1],
                              groupValue: provider.select,
                              onChanged: (value) =>
                                  provider.onClickRadioButton(value),
                            ),
                            const Text(StringConstants.female),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      ElevatedButtonWidget(
                        onPressed: () {
                          if (formKey.currentState.validate() ?? false) {
                            UserModel user = UserModel(
                                email: provider.emailController.text,
                                gender: provider.select,
                                name: provider.nameController.text,
                                password: provider.passwordController.text,
                                phoneNo: provider.phoneController.text,
                                image: "");

                            provider.signUp(user);
                          }
                          log("Please fill the details");
                        },
                        text: StringConstants.signUp,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
