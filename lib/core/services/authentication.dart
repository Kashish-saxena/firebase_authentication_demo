// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_demo/services/firebase_api.dart';

// class Authentication{
//   static Future<User?> signUp(String email, String password) async {
//       if (email.isEmpty || password.isEmpty) {
//        log("Please enter details...");
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
//           await FirebaseApi(uid: userCredential.user?.uid ?? "")
//               .registerUser(email, password);
//           return userCredential.user;
//         } on FirebaseAuthException catch (e) {
//          log(e.code.toString());
//         }
//       }
//       return null;
//     }

// }