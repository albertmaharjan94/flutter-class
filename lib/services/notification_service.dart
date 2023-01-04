import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
class NotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin
  = FlutterLocalNotificationsPlugin();

  static void initialize(){
    final InitializationSettings initializationSettings
    = InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
      iOS: DarwinInitializationSettings(
        requestSoundPermission: false,
        requestBadgePermission: false,
        requestAlertPermission: false
      )
    );
    _notificationsPlugin.initialize(initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse
    );
  }
  static BuildContext? context;
  static void onDidReceiveNotificationResponse
      (NotificationResponse? response){
      if(response!=null && response.payload!=null){
        Navigator.of(context!).pushNamed(response.payload.toString());
        print(response.payload);
      }
  }

  static Future<String> getImageFilePathFromAssets(
      String asset, String filename) async {
    final byteData = await rootBundle.load(asset);
    final temp_direactory = await getTemporaryDirectory();
    final file = File('${temp_direactory.path}/$filename');
    await file.writeAsBytes(byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes));
    return file.path;
  }

  static Future<void> display(
      String title, String body,String payload, BuildContext _context
      ) async {
    context = _context;
    // if image from asset
    final bigpicture = await getImageFilePathFromAssets(
        'assets/images/logo.png', 'bigpicture');
    final smallpicture = await getImageFilePathFromAssets(
        'assets/images/logo.png', 'smallpicture');

    final styleinformationDesign = BigPictureStyleInformation(
      FilePathAndroidBitmap(smallpicture),
      largeIcon: FilePathAndroidBitmap(bigpicture),
    );


    final id = DateTime.now().millisecondsSinceEpoch ~/1000;
    final NotificationDetails notificationDetails
    = NotificationDetails(
      android: AndroidNotificationDetails(
        "myapp",
        "myapp channel",
        channelDescription: "Channel Description",
        importance: Importance.max,
        priority: Priority.high,
        styleInformation: styleinformationDesign
      ),
      iOS: DarwinNotificationDetails()
    );
    _notificationsPlugin.show(
        id, title, body, notificationDetails,
        payload: payload
    );
  }
}