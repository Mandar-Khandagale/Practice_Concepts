import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatteryLevel extends StatefulWidget {
  @override
  _BatteryLevelState createState() => _BatteryLevelState();
}

class _BatteryLevelState extends State<BatteryLevel> {

  String _batteryPer = 'Battery %';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Platform Specific'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _getBatteryInfo,
              color: Colors.lightBlue,
              child: Text('Get Battery %',),
                ),
            SizedBox(height: 20.0,),
            Text(_batteryPer,style: TextStyle(fontSize: 25.0),)
          ],
        ),
      ),
    );
  }

  static const batteryChannel = const MethodChannel('battery');

  Future<void> _getBatteryInfo() async{
    String batteryPercentage;
    try{
      var result = await batteryChannel.invokeMethod('getBatteryLevel');
      batteryPercentage = 'Battery Level at $result%';
    }on PlatformException catch(e){
      batteryPercentage = 'Failed to get Battery level ${e.message}.';
    }

    setState(() {
      _batteryPer = batteryPercentage;
    });
  }
}
