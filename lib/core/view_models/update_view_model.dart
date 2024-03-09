import 'dart:developer';
import 'dart:io';
import 'package:firebase_demo/core/constants/string_constant.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_demo/core/services/firebase_services.dart';
import 'package:firebase_demo/core/view_models/base_model.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


class UpdateViewModel extends BaseModel {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  final updateKey = GlobalKey<FormState>();
  final List<String> genderList = ["male", "female"];
  String? gender = "female";
  FirebaseServices services = FirebaseServices();
String image="";
  void onClickRadioButton(value) {
    gender = value;
    updateUI();
  }

  final ImagePicker _imagePicker = ImagePicker();

  File? selectedProfile;
 
  Future pickImageFromCamera() async {
    final profile = await _imagePicker.pickImage(source: ImageSource.camera);
    if (profile == null) {
      return;
    }
    selectedProfile = File(profile.path);
    image = await services.uploadImageToFirebase(selectedProfile!);
    updateUI();
  }

    Future pickImageFromGallery() async {
    final profile = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (profile == null) {
      return;
    }
    selectedProfile = File(profile.path);
    image = await services.uploadImageToFirebase(selectedProfile!);
    updateUI();
  }

  
  // Future uploadFile() async {
  //   if (photo == null) {
  //     return;
  //   }
  //   final fileName = basename(photo?.path ?? '');
  //   image = fileName;

  //   try {
  //     final ref = _firebaseStorage.ref().child(fileName);
  //     await ref.putFile(photo!);
  //     final url = await ref.getDownloadURL();
  //     log('url is $url');
  //   } catch (e) {
  //     log('error is $e');
  //   }
  // }

  Future<void> updateInformation(
      BuildContext context, UserModel userDetail) async {
    try {
      if (updateKey.currentState?.validate() ?? false) {
        String updatedName = nameController.text;
        String updatedEmail = emailController.text;
        String updatedPhone = phoneController.text;
        if (updatedName != userDetail.name ||
            updatedEmail != userDetail.email ||
            updatedPhone != userDetail.phoneNo ||
            gender != userDetail.gender ||image.isNotEmpty) {
          UserModel user = UserModel(
            id: userDetail.id,
            name: updatedName,
            email: updatedEmail,
            phoneNo: updatedPhone,
            password: userDetail.password,
            gender: gender,
            image: image,
          );
          await services.updateUserDetails(user);
          // updateUserFields(context,userDetail);
          if(context.mounted){
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(StringConstants.detailsUpdated)));}
        }
      }
    } catch (e) {
      if(context.mounted){
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text(StringConstants.detailsUpdated)));}
      log(e.toString());
    }
  }
}


// void updateUserFields(BuildContext context,UserModel user,)async{
//   await FirebaseApi().getUserDetails(user.id??"");
//   Navigator.push(context,MaterialPageRoute(builder: (context)=>UpdateScreen(userDetail: user)));
//   updateUI();
// }
