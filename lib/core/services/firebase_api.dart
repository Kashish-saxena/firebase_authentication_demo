import 'dart:developer';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_demo/core/models/user_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseApi {
  // final String uid;
  // FirebaseApi({required this.uid});
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
      
  final _random = Random();

  String getString() {
    String s = "";
    for (var i = 0; i < 12; i++) {
      s += _random.nextInt(10).toString();
    }
    return s;
  }

  Future registerUser(UserModel user) async {
    try {
      return await userCollection.doc(getString()).set(
        user.toJson(),
      );
    } on FirebaseException catch (e) {
      print("<<<<<<<<<<<<<<<<<<<<<<<<< $e >>>>>>>>>>>>>>>>>>>>>>>>>");
    }
  }

}











//   Future<void> initNotification() async {
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
