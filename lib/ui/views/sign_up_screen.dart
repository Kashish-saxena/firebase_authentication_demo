import 'package:firebase_demo/core/constants/color_consant.dart';
import 'package:firebase_demo/core/constants/string_constant.dart';
import 'package:firebase_demo/core/enums/view_state.dart';
import 'package:firebase_demo/core/utils/validations.dart';
import 'package:firebase_demo/core/view_models/sign_up_view_model.dart';
import 'package:firebase_demo/ui/views/base_view.dart';
import 'package:firebase_demo/ui/widgets/elevated_button.dart';
import 'package:firebase_demo/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});
  SignUpViewModel? model;
  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;

    return BaseView<SignUpViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return SafeArea(
          
          child: Scaffold(
            body: buildBody(deviceHeight, deviceWidth, model, context),
          ),
        );
      },
    );
  }

  Widget buildBody(deviceHeight, deviceWidth, model, context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child:SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight ,
          // padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom*.20),
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
              model.state == ViewState.idle
                  ? buildForm(context, deviceHeight, deviceWidth, model)
                  : const Center(
                      child: CircularProgressIndicator(
                        color: ColorConstants.black,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildForm(BuildContext context, double deviceHeight,
      double deviceWidth, SignUpViewModel model) {
    return Positioned(
      top: deviceHeight * 0.2,
      width: deviceWidth,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 70),
        height: deviceHeight ,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
          color: ColorConstants.white,
        ),
        child: Form(
          key: model.formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TextFormFieldWidget(
                labelText: StringConstants.name,
                obscureText: false,
                controller: model.nameController,
                validator: (name) {
                  return Validations.isNameValid(name);
                },
              ),
              TextFormFieldWidget(
                labelText: StringConstants.email,
                obscureText: false,
                controller: model.emailController,
                validator: (email) {
                  return Validations.isEmailValid(email);
                },
              ),
              TextFormFieldWidget(
                labelText: StringConstants.phone,
                obscureText: false,
                controller: model.phoneController,
                validator: (phone) {
                  return Validations.isPhoneNoValid(phone);
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
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                  border: Border.all(
                      style: BorderStyle.solid, color: ColorConstants.grey),
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
                          fontSize: 18,
                          color: ColorConstants.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Radio(
                      activeColor: Colors.blue,
                      value: model.gender[0],
                      groupValue: model.select,
                      onChanged: (value) => model.onClickRadioButton(value),
                    ),
                    const Text(
                      StringConstants.male,
                      style: TextStyle(fontSize: 18),
                    ),
                    Radio(
                      activeColor: Colors.blue,
                      value: model.gender[1],
                      groupValue: model.select,
                      onChanged: (value) => model.onClickRadioButton(value),
                    ),
                    const Text(
                      StringConstants.female,
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButtonWidget(
                onPressed: () async {
                  await model.signUp(context);
                },
                text: StringConstants.signUp,
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
