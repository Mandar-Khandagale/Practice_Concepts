import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';


class PushNotification extends StatefulWidget {
  @override
  _PushNotificationState createState() => _PushNotificationState();
}

class _PushNotificationState extends State<PushNotification> {

  String messageTitle = "Empty";
  String notificationAlert = "alert";

  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  @override
  void initState() {
    super.initState();
    _firebaseMessaging.configure(
      onMessage: (message) async{
        setState(() {
          messageTitle = message['notification']['title'];
          notificationAlert = 'New Notification Alert';
        });
      },
      onResume: (message) async{
        setState(() {
          messageTitle = message['data']['title'];
          notificationAlert = 'Application Open From Notification, app background';
        });
      },
      onLaunch: (message) async{
        setState(() {
          messageTitle = message['data']['title'];
          notificationAlert = 'Application Launched from Notification';
        });
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Push Notification'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              notificationAlert,
            ),
            Text(
              messageTitle,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
    );
  }
}
