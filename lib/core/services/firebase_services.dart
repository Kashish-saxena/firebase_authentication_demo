import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class FirebaseServices {
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
 String image="" ;
  Future registerUser(UserModel user) async {
    try {
      await userCollection.doc(user.id).set(
            user.toJson(),
          );
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user.id)
          .get();
      log("<<<<<<<<<<<<<${snapshot.data().toString()}");
    } on FirebaseException catch (e) {
      log("<<<<<<<<<<<<<<<<<<<<<<<<< $e >>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

  Future<UserModel> getUserDetails(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: id)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;
    log(userData.toString());
    return userData;
  }

  Future<UserModel> checkCredentials(String id) async {
    final snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where("id", isEqualTo: id)
        .get();
    final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).single;

    log(userData.toString());
    return userData;
  }

  Future<String> uploadImageToFirebase(File imageFile) async {
    try {
      // Upload image to Firebase Storage
      final fileName = basename(imageFile.path);
      final ref = _firebaseStorage.ref().child('images').child(fileName);
      await ref.putFile(imageFile);

      image = await ref.getDownloadURL();

      log('Image uploaded successfully$image');
      return image;
    } catch (e) {
      log('Error uploading image: $e');
    }
    return image;
  }

  // Future<List<UserModel>> getAllUserDetails() async {
  //   final snapshot = await FirebaseFirestore.instance.collection("users").get();
  //   final userData = snapshot.docs.map((e) => UserModel.fromJson(e)).toList();
  //   return userData;
  // }

  Future updateUserDetails(UserModel user) async {
    await userCollection.doc(user.id).update(
          user.toJson(),
        );
  }
}











//   Future<void> initNotification() async {
  // final FlutterLocalNotificationsPlugin notificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
//     AndroidInitializationSettings initializationSettingsAndroid =
//         const AndroidInitializationSettings('logo');

//     var initializationSettingsIOS = DarwinInitializationSettings(
//         requestAlertPermission: true,
//         requestBadgePermission: true,
//         requestSoundPermission: true,
//         onDidReceiveLocalNotification:
//             (int id, String? title, String? body, String? payload) async {});

//     var initializationSettings = InitializationSettings(
//         android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
//     await notificationsPlugin.initialize(initializationSettings,
//         onDidReceiveNotificationResponse:
//             (NotificationResponse notificationResponse) async {});
//   }

//   notificationDetails() {
//     return const NotificationDetails(
//         android: AndroidNotificationDetails('channelId', 'channelName',
//             importance: Importance.max),
//         iOS: DarwinNotificationDetails());
//   }

//   Future showNotification(
//       {int id = 0, String? title, String? body, String? payLoad}) async {
//     return notificationsPlugin.show(
//         id, title, body, await notificationDetails());
//   }

  // GetData from firestore
  // DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection("users").doc("sTxHPktGC8aHTDNU4gNW").get();
  // print("<<<<<<<<<<<<<${snapshot.data().toString()}");

  // NotificationSettings settings = await _firebaseMessaging.requestPermission(
  //   alert: true,
  //   announcement: false,
  //   badge: true,
  //   carPlay: false,
  //   criticalAlert: false,
  //   provisional: false,
  //   sound: true,
  // );

  // if (settings.authorizationStatus == AuthorizationStatus.authorized) {
  //   log('User granted permission');
  // } else if (settings.authorizationStatus ==
  //     AuthorizationStatus.provisional) {
  //   log('User granted provisional permission');
  // } else {
  //   log('User declined or has not accepted permission');
  // }
  // final fCMToken = await _firebaseMessaging.getToken();
  // log("Token: $fCMToken");

  // FirebaseMessaging.onMessage.listen((RemoteMessage event) {
  //   log("message recieved");
  //   log("${event.notification!.body}");
  //   log("${event.data.values}");
  // });
