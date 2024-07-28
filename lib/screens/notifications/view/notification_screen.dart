import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //get the notification message and display on screen
    final RemoteMessage? message =
        ModalRoute.of(context)!.settings.arguments as RemoteMessage?;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Notification",
          style: GoogleFonts.acme(
            textStyle: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          // Text(message.notification!.title.toString() ?? null),
          // Text(message.notification!.body.toString()),
          // Text(message.data.toString()),
        ],
      ),
    );
  }
}
