import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form/flutter_sensors/barcode_generator.dart';
import 'package:form/flutter_sensors/barcode_scanner.dart';
import 'package:sensors/sensors.dart';

class SensorReadings extends StatefulWidget {
  @override
  _SensorReadingsState createState() => _SensorReadingsState();
}

class _SensorReadingsState extends State<SensorReadings> {

  double x,y,z;
  double a,b,c;
  @override
  void initState() {
    gyroscopeEvents.listen((event) {
      setState(() {
        x = event.x;
        y = event.y;
        z = event.z;
      });
    });
    accelerometerEvents.listen((event) {
      setState(() {
        a = event.x;
        b = event.y;
        c = event.z;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sensor Readings'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Gyroscope Sensor Reading :-',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.red,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  children: [
                    _tableRowWidget('X-axis',x),
                    _tableRowWidget('Y-axis', y),
                    _tableRowWidget('Z-axis', z),
                  ],
                ),
              ),
              SizedBox(height: 50.0,),
              Text('Accelerometer Sensor Reading :-',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Table(
                  border: TableBorder.all(
                    color: Colors.blue,
                    width: 2.0,
                    style: BorderStyle.solid,
                  ),
                  children: [
                    _tableRowWidget('X-axis',a),
                    _tableRowWidget('Y-axis', b),
                    _tableRowWidget('Z-axis', c),
                  ],
                ),
              ),
              SizedBox(height: 50.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    color: Colors.green,
                    child: Text('Create Barcode'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BarcodeGenerator()));
                    },
                  ),
                  RaisedButton(
                    color: Colors.green,
                    child: Text('Scan Barcode'),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>BarcodeScanner()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _tableRowWidget(String axis, double val){
    return     TableRow(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(axis),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(val == null ? '' : val.toStringAsFixed(2)),
          ),
        ]
    );
  }

}
