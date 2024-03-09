import 'package:firebase_demo/core/constants/color_consant.dart';
import 'package:firebase_demo/core/constants/string_constant.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/utils/validations.dart';
import 'package:firebase_demo/core/view_models/update_view_model.dart';
import 'package:firebase_demo/ui/views/base_view.dart';
import 'package:firebase_demo/ui/widgets/elevated_button.dart';
import 'package:firebase_demo/ui/widgets/text_form_field.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class UpdateScreen extends StatelessWidget {
  UpdateScreen({super.key, required this.userDetail});
  final UserModel userDetail;
  UpdateViewModel? model;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BaseView<UpdateViewModel>(
          onModelReady: (model) {
            this.model = model;
          },
          builder: (context, model, child) {
            return buildBody(context, model);
          },
        ),
      ),
    );
  }

  Widget buildBody(BuildContext context, UpdateViewModel model) {
    double deviceHeight = MediaQuery.of(context).size.height;
    double deviceWidth = MediaQuery.of(context).size.width;
    model.nameController.text = userDetail.name ?? "";
    model.emailController.text = userDetail.email ?? "";
    model.phoneController.text = userDetail.phoneNo ?? "";
    // model.gender = userDetail.gender??"" ;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        // Navigator.of(context).pop();
      },
      child: SingleChildScrollView(
        child: SizedBox(
          height: deviceHeight,
          child: Stack(children: [
            buildProfile(context, deviceHeight, deviceWidth, model),
            Positioned(
              top: deviceHeight * .30,
              child: Container(
                width: deviceWidth,
                decoration: const BoxDecoration(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(30))),
                child: buildForm(context, deviceHeight, deviceWidth, model),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget buildProfile(BuildContext context, double deviceHeight,
      double deviceWidth, UpdateViewModel model) {
    return Container(
      padding: const EdgeInsets.only(top: 60),
      alignment: Alignment.topCenter,
      height: deviceHeight * .40,
      color: ColorConstants.black,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: deviceHeight * .20,
            decoration: const BoxDecoration(shape: BoxShape.circle),
            child: model.selectedProfile != null
                ? Image.network(
                    model.image,
                    fit: BoxFit.fill,
                  )
                : Image.asset(
                    "assets/images/profile.png",
                    scale: 1,
                  ),
          ),
          Positioned(
            bottom: 20,
            right: -8,
            child: Container(
              decoration: BoxDecoration(
                  color: ColorConstants.white,
                  borderRadius: BorderRadius.circular(30)),
              child: IconButton(
                onPressed: () {
                  buildImagePicker(context, deviceHeight, deviceWidth);
                  // Navigator.pop(context);
                },
                icon: const Icon(Icons.edit),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildForm(BuildContext context, double deviceHeight,
      double deviceWidth, UpdateViewModel model) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 90),
          height: deviceHeight,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60)),
            color: ColorConstants.white,
          ),
          child: Form(
            key: model.updateKey,
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
                SizedBox(
                  width: deviceWidth,
                  child: TextFormFieldWidget(
                    labelText: StringConstants.phone,
                    obscureText: false,
                    controller: model.phoneController,
                    validator: (phone) {
                      return Validations.isPhoneNoValid(phone);
                    },
                  ),
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
                        value: model.genderList[0],
                        groupValue: model.gender,
                        onChanged: (value) => model.onClickRadioButton(value),
                      ),
                      const Text(
                        StringConstants.male,
                        style: TextStyle(fontSize: 18),
                      ),
                      Radio(
                        activeColor: Colors.blue,
                        value: model.genderList[1],
                        groupValue: model.gender,
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
                    await model.updateInformation(context, userDetail);
                  },
                  text: StringConstants.update,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void buildImagePicker(BuildContext context, deviceHeight, deviceWidth) {
    showBottomSheet(
        backgroundColor: ColorConstants.black,
        context: context,
        builder: (builder) {
          return SizedBox(
            width: deviceWidth,
            height: deviceHeight * .09,
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => model?.pickImageFromCamera(),
                    child: const Icon(
                      Icons.camera_alt,
                      color: ColorConstants.white,
                      size: 35,
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () => model?.pickImageFromGallery(),
                    child: const Icon(
                      Icons.image_rounded,
                      color: ColorConstants.white,
                      size: 35,
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
