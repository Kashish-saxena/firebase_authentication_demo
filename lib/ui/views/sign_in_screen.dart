import 'package:firebase_demo/core/constants/color_consant.dart';
import 'package:firebase_demo/core/constants/string_constant.dart';
import 'package:firebase_demo/core/enums/view_state.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/utils/validations.dart';
import 'package:firebase_demo/core/view_models/Sign_in_view_model.dart';
import 'package:firebase_demo/ui/views/base_view.dart';
import 'package:firebase_demo/ui/widgets/elevated_button.dart';
import 'package:firebase_demo/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignInScreen extends StatelessWidget {
  SignInScreen({super.key, required this.userDetail});
  final UserModel userDetail;
  SignInViewModel? model;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return BaseView<SignInViewModel>(onModelReady: (model) {
      this.model = model;
    },
    builder:(context, model, child) {
      return Scaffold(
        body: buildBody(deviceHeight, deviceWidth, model, context,userDetail),
      );
    },
    );
  }

  Widget buildBody(deviceHeight, deviceWidth, model, context, userDetail) {
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
                  child: const Text(StringConstants.signIn,
                      style: TextStyle(color: Colors.white, fontSize: 30)),
                ),
              ),
            ),
            model.state == ViewState.idle
                ? Positioned(
                    top: deviceHeight * 0.2,
                    width: deviceWidth,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 25, vertical: 70),
                      height: deviceHeight * .9,
                      decoration: const BoxDecoration(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(60)),
                        color: ColorConstants.white,
                      ),
                      child: Form(
                        // key: model.formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(userDetail.id),
                            TextFormFieldWidget(
                              labelText: StringConstants.email,
                              obscureText: false,
                              controller: model.emailController,
                              validator: (email) {
                                return Validations.isEmailValid(email);
                              },
                            ),
                            TextFormFieldWidget(
                              labelText: StringConstants.password,
                              obscureText: true,
                              controller: model.passwordController,
                              validator: (password) {
                                return Validations.isPasswordValid(password);
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButtonWidget(
                              onPressed: () async {
                                await model.signIn(context,userDetail.id,userDetail);

                              },
                              text: StringConstants.signUp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.black,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
