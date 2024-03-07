// import 'dart:developer';
// import 'dart:io';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_demo/core/constants/color_consant.dart';
// import 'package:firebase_demo/core/constants/string_constant.dart';
// import 'package:firebase_demo/core/services/firebase_api.dart';
// import 'package:firebase_demo/core/utils/image_picker.dart';
// import 'package:firebase_demo/core/utils/validations.dart';
// import 'package:firebase_demo/ui/widgets/alert_dialog.dart';
// import 'package:firebase_demo/ui/widgets/elevated_button.dart';
// import 'package:firebase_demo/ui/widgets/text_form_field.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';

// class UpdateScreen extends StatefulWidget {
//   const UpdateScreen({super.key});

//   @override
//   State<UpdateScreen> createState() => _UpdateScreenState();
// }

// class _UpdateScreenState extends State<UpdateScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: buildBody(context),
//     ));
//   }

//   Widget buildBody(context) {
//     TextEditingController emailController = TextEditingController();
//     TextEditingController passwordController = TextEditingController();
//     String fetchedImage = "";

//       ImagePicker imagePicker = ImagePicker();
//       File? file;
//     // // File? imageFile;
//     // final ImagePicker imagePicker = ImagePicker();

//     // Future pickImagefromGallery() async {
//     //   final pickedImage =
//     //       await imagePicker.pickImage(source: ImageSource.camera);

//     //   setState(() {
//     //     if (pickedImage != null) {
//     //       // imageFile = File(pickedImage.path);

//     //       UploadData().uploadToDatabase(pickedImage as File);
//     //       log('User picked an image.');

//     //       log("file:::${pickedImage.path}");

//     //       log('<<<<<<<<<<<<<<<User picked an image.>>>>>>>>>');
//     //     } else {}
//     //   });
//     // }

//     Future pickImagefromCamera() async {
//       final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
//       log("${pickedFile?.path}");

//       setState(() {
//         if(pickedFile!=null){
// file = File(pickedFile.path);
//         }
//      UploadData().uploadToDatabase(file);
//       });
//     }

//     Future<User?> signUp(String email, String password, String image) async {
//       if (email.isEmpty || password.isEmpty) {
//         showDialog(
//           context: context,
//           builder: (context) {
//             return const AlertDialogWidget(
//                 text: StringConstants.enterEmailPassword);
//           },
//         );
//       } else {
//         try {
//           UserCredential userCredential = await FirebaseAuth.instance
//               .createUserWithEmailAndPassword(email: email, password: password);
//           // .then((value) => showDialog(
//           //       context: context,
//           //       builder: (context) {
//           //         return const AlertDialogWidget(
//           //             text: "Sign Up Successful");
//           //       },
//           //     ));
//           log("Sign Up Successful");
//           await FirebaseApi().registerUser(email, password, image,phone,gender);
//           return userCredential.user;
//         } on FirebaseAuthException catch (e) {
//           showDialog(
//               context: context,
//               builder: (context) {
//                 return AlertDialogWidget(text: e.code.toString());
//               });
//         }
//       }
//       return null;
//     }

//     return SingleChildScrollView(
//       child: Container(
//         height: MediaQuery.of(context).size.height,
//         padding: const EdgeInsets.all(0),
//         child: Stack(
//           children: [
//             Positioned(
//               height: MediaQuery.of(context).size.height * .4,
//               width: MediaQuery.of(context).size.width,
//               child: Container(
//                 color: ColorConstants.black,
//                 child: Container(
//                   alignment: Alignment.center,
//                   child: Stack(
//                     children: [
//                       Container(
//                         height: MediaQuery.of(context).size.height * .10,
//                         width: MediaQuery.of(context).size.width * .20,
//                         decoration: BoxDecoration(
//                           color: Colors.blue,
//                           borderRadius: BorderRadius.circular(45),
//                         ),
//                         child:
//                             // imageFile != null
//                             //     ? SizedBox(
//                             //         height: 100,
//                             //         width: 100,
//                             //         child: Image.file(
//                             //           imageFile!,
//                             //           fit: BoxFit.fill,
//                             //         ),
//                             //       )
//                             // :
//                             // Image.network(fetchedImage),
//                             Image.asset("assets/images/flutter_logo.png"),
//                       ),
//                       Positioned(
//                         top: 50,
//                         right: -5,
//                         child: Container(
//                           color: ColorConstants.black,
//                           child: IconButton(
//                               onPressed: () async {
//                                 pickImagefromCamera();
//                               },
//                               icon: const Icon(
//                                 Icons.edit,
//                                 color: ColorConstants.white,
//                               )),
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               top: MediaQuery.of(context).size.height * .3,
//               width: MediaQuery.of(context).size.width,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   borderRadius: BorderRadius.only(topLeft: Radius.circular(50)),
//                   color: ColorConstants.white,
//                 ),
//                 child: Form(
//                   autovalidateMode: AutovalidateMode.onUserInteraction,
//                   child: Column(
//                     children: [
//                       const Padding(
//                           padding: EdgeInsets.symmetric(vertical: 50),
//                           child: Text(
//                             StringConstants.signUp,
//                             style: TextStyle(fontSize: 30),
//                           )),
//                       TextFormFieldWidget(
//                         labelText: StringConstants.email,
//                         obscureText: false,
//                         controller: emailController,
//                         validator: (email) {
//                           return Validations.isEmailValid(email);
//                         },
//                       ),
//                       TextFormFieldWidget(
//                         labelText: StringConstants.password,
//                         obscureText: true,
//                         controller: passwordController,
//                         validator: (password) {
//                           return Validations.isPasswordValid(password);
//                         },
//                       ),
//                       const SizedBox(
//                         height: 30,
//                       ),
//                       ElevatedButtonWidget(
//                         onPressed: () async {
//                           log(fetchedImage);
//                           await signUp(emailController.text.toString(),
//                               passwordController.text.toString(), fetchedImage);
//                         },
//                         text: StringConstants.signUp,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
// // IconButton(
// //                         icon: const Icon(Icons.edit),
// //                         onPressed: () async {
// //                           await pickImagefromGallery();
// //                         }),
// //                            isImageSelected == true
// //                         ? Container(

// //                             height: MediaQuery.of(context).size.height * .15,
// //                             // width: MediaQuery.of(context).size.width/3,
// //                             clipBehavior: Clip.antiAlias,
// //                             decoration:

// //                                 const BoxDecoration(shape: BoxShape.circle),
// //                             child: Image(
// //                               image: FileImage(imageFile!),
// //                             ),
// //                           )
// //                         : Container(color: Colors.white,),
