import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_teach2/app_view.dart';
import 'package:http/http.dart' as http;

class FirebaseApi {
  // create an instance of Firebase Messaging
  final _firebaseMessaging = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    // request permission from user (will prompt user)
    await _firebaseMessaging.requestPermission();

    //fetch the FCM token for this device
    final fcmToken = await _firebaseMessaging.getToken();

    // print the token(normally you would send this to your server)
    print('Token: $fcmToken');

    //initialize further settings for push notification
    initPushNotifications();
  }

  // function to handle received messages
  void handleMessage(RemoteMessage? message) {
    // if the message is null, do nothing
    if (message == null) return;

    // navigate to new screen when message is received and user tap notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // function to initialize foreground and background settings
  Future initPushNotifications() async {
    // handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }

  Future<void> sendNotification(String title, String body) async {
    final serverToken = initNotifications();
    print("Server: $serverToken");
    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'key=$serverToken',
      },
      body: jsonEncode({
        'to': '/topics/all',
        'notification': {
          'title': title,
          'body': body,
        },
      }),
    );

    if (response.statusCode != 200) {
      print('Failed to send notification: ${response.body}');
    } else {
      print('Notification sent successfully!');
    }
  }
}
