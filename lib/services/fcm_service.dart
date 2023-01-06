import 'dart:convert';
import 'package:http/http.dart' as http;


class FCMService{
  static const String FCMAPI = "AAAAMrwPyiM:APA91bF_JmEzhaYMsJihPK7xkLItaB_ZaUP7s7DrDQe4NsmTw5DH2w0j0Qn2mYkBcrMBw0NFMNk-WQlWZ2NrJo9Gtcyo9iNCrQ1yx4dXqhpGokuBcP5yDzExsC60lPLKRLl2-n6X4q_A";
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

