// create FCM service

import 'dart:convert';
import 'package:http/http.dart' as http;


class FCMService{
  static const String FCMAPI = "AAAASj_Xp-g:APA91bGlhy3apkslnPgFwJ87sHi_aZorykhQIMdJw2RQ_7f4wpj4suuoCkX5F0U0T4KZhA4uZULo0HLx6bN2sn7FVAX63JCzW9wc8Z_T-GUtntw6Npnh2KASAuNufWp5qpuFRKGFuXZE";
  static String makePayLoadWithToken(String? token,
      Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'to': token,
      'data': data,
      'notification': notification,
    });
  }

  static String makePayLoadWithTopic(String? topic,
      Map<String, dynamic> data,
      Map<String, dynamic> notification) {
    return jsonEncode({
      'topic': topic,
      'data': data,
      'notification': notification,
    });
  }

  static Future<void> sendPushMessage(String? token,
      Map<String, dynamic> data,
      Map<String, dynamic> notification) async {
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=$FCMAPI'
        },
        body: makePayLoadWithToken(token, data, notification),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }
}

