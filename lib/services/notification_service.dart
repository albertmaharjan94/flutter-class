import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin
  _notificationsPlugin = FlutterLocalNotificationsPlugin();

  static void initialize(){
    final InitializationSettings initializationSettings =
        InitializationSettings(
          android: AndroidInitializationSettings("@mipmap/ic_launcher"),
          iOS: DarwinInitializationSettings(
            requestAlertPermission: false,
            requestBadgePermission: false,
            requestSoundPermission: false
          )
        );

    _notificationsPlugin.initialize(initializationSettings,
     onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
    );
  }
  static void onDidReceiveNotificationResponse
      (NotificationResponse notificationResponse) async{
    final String? payload = notificationResponse.payload;
    print(payload);
  }



  static void display(String title, String body, String payload){
    final id = DateTime.now().millisecondsSinceEpoch ~/1000;
    final NotificationDetails notificationDetails= NotificationDetails(
      android: AndroidNotificationDetails(
        "my-app-name",
        "my-app-channel",
        channelDescription: "my-channel-description ...",
        importance: Importance.max,
        priority: Priority.high
      ),
      iOS: DarwinNotificationDetails(),
    );
    _notificationsPlugin.show(id, title, body, notificationDetails,
        payload: payload);
  }

}