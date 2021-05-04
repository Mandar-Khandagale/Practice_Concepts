import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Local Notification Handling in flutter

class LocalNotification extends StatefulWidget {
  @override
  _LocalNotificationState createState() => _LocalNotificationState();
}

class _LocalNotificationState extends State<LocalNotification> {

  FlutterLocalNotificationsPlugin _flutterLocalNotifications = FlutterLocalNotificationsPlugin();
  String task;
  String selectTime;
  int selectDuration;

  @override
  void initState() {
    super.initState();
    var androidInitialize = AndroidInitializationSettings('app_icon');
    var iosInitialize = IOSInitializationSettings();
    var initializeSetting = InitializationSettings(androidInitialize, iosInitialize);
    _flutterLocalNotifications.initialize(initializeSetting,onSelectNotification: notificationSelected);
  }

  // to show instant notification on button pressed
  Future _showInstantNotification() async{
    var androidDetails = AndroidNotificationDetails('Mandar', 'Test Notification', 'My 1st test notification',
    importance: Importance.High);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(androidDetails, iosDetails);

    await _flutterLocalNotifications.show(0, 'Test Notification', 'My test instant notification', generalNotificationDetails);
  }
  // to show scheduled notification on button pressed after given period of time
  Future _showScheduledNotification() async {
    var androidDetails = AndroidNotificationDetails('Mandar', 'Test Notification', 'My 1st test notification',
        importance: Importance.High);
    var iosDetails = IOSNotificationDetails();
    var generalNotificationDetails = NotificationDetails(androidDetails, iosDetails);

    var scheduleTime ; // DateTime.now().add(Duration(seconds: 5));
    if(selectTime == 'Hours'){
      scheduleTime = DateTime.now().add(Duration(hours: selectDuration));
    }else if(selectTime == 'Minutes'){
      scheduleTime = DateTime.now().add(Duration(minutes: selectDuration));
    }else{
      scheduleTime = DateTime.now().add(Duration(seconds: selectDuration));
    }
     _flutterLocalNotifications.schedule(1, 'Test Notification',
        task, scheduleTime, generalNotificationDetails, payload: 'Add Today Task');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Local Notifications"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.all(10.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (val){
                  task = val;
                },
              ),
            ),
            SizedBox(height: 20.0,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                DropdownButton(
                    value: selectTime,
                    items: [
                      DropdownMenuItem(child: Text('Seconds'),value: 'Seconds',),
                      DropdownMenuItem(child: Text('Minutes'),value: 'Minutes',),
                      DropdownMenuItem(child: Text('Hours'),value: 'Hours',),
                    ],
                    hint: Text('Select Time Period'),
                    onChanged: (val){
                      setState(() {
                        selectTime = val;
                      });
                    }),
                DropdownButton(
                    value: selectDuration,
                    items: [
                      DropdownMenuItem(child: Text('1'),value: 1,),
                      DropdownMenuItem(child: Text('2'),value: 2,),
                      DropdownMenuItem(child: Text('3'),value: 3,),
                      DropdownMenuItem(child: Text('4'),value: 4,),
                      DropdownMenuItem(child: Text('5'),value: 5,),
                    ],
                    hint: Text('Select Duration'),
                    onChanged: (val){
                      setState(() {
                        selectDuration = val;
                      });
                    }),
              ],
            ),
            SizedBox(height: 20.0,),
            RaisedButton.icon(
                onPressed: _showInstantNotification,
                icon: Icon(Icons.notifications),
                label: Text('Get Instant Notification'),
            ),
            SizedBox(height: 20.0,),
            RaisedButton.icon(
              onPressed: _showScheduledNotification,
              icon: Icon(Icons.notification_important_outlined),
              label: Text('Get Scheduled Notification'),
            ),
          ],
        ),
      ),
    );
  }

  Future notificationSelected(String payload) async{
    showDialog(
        context: context,
      builder: (context)=>AlertDialog(
        content: Text('Clicked on Notification $payload'),
        actions: [
          FlatButton(
              onPressed:(){
                Navigator.pop(context);
              },
              child: Text('Ok',style: TextStyle(fontSize: 15.0,color: Colors.black),)),
        ],
      )
    );
  }

}
