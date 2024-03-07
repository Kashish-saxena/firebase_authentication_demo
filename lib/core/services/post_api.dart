import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class PostApi {
  void sendNotificationToTopic(String title) async {

    try {
      http.Response response = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAgXlQaNE:APA91bFdEJdGgqhDBX2EoVChr2kGJOpy04lCQCdD2w_pqR2EdmlMwIITfAz7-pEbLvezNbx3TznJNcWrjI5jdpujiV0VeVGoM2vhRmhZoHOU1q7Wimajn38hP-oLQ3W3AlpSiowJA8qC',
        },
        
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': "You have subscribed to this channel.",
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'message': title,
            },
            "to": "/topics/subscription'"
                // "f7eLM9lYTTKexa6Q4KB-ZB:APA91bG4sW5FjMC3YPDf_obDQ4c_wwR9VznqSN58_9ZEO5pQXRlbgJ544inxyBdyB7BqlTCcNyd6RbcJIa_j1Vs12K98V-ygQEZiy8lHeQFrdeFt9MbB-vwvW3TCO1UK9h1M05L93WMm",
          },
        ),
      );

      if(response.statusCode==200){
        log("Notification send");
      }else{
        log("Error");
      }
      log('done');
    } catch (e) {
      log("error push notification");
    }
  }
}
