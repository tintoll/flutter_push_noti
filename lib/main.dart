import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_push_noti/background_message_handler.dart';

void main() {
  runApp(MyApp());
}

// StatefullWidget이면 init 메서드에서 작성하면 된다.
class MyApp extends StatelessWidget {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  Widget build(BuildContext context) {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage : $message");
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch : $message");
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume : $message");
      },
      onBackgroundMessage: myBackgroundMessgageHandler,
    );
     // IOS 설정
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered : $settings");
    });

    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token : $token");
    });

    return MaterialApp(
      title: 'Flutter Demo',
      home: Container(),
    );
  }
}
