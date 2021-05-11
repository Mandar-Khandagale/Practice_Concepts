import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class BarcodeScanner extends StatefulWidget {
  @override
  _BarcodeScannerState createState() => _BarcodeScannerState();
}

class _BarcodeScannerState extends State<BarcodeScanner> {

  String barcode = "Unknown";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Barcode Scanner'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Scan Result',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),
            ),
            SizedBox(height: 10.0),
            Text("$barcode",style: TextStyle(fontSize: 28.0,),),
            SizedBox(height: 70.0,),
            RaisedButton(
              child: Text('Start Barcode SCan'),
              onPressed: (){
                scanBarcode();
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<void> scanBarcode() async{
    try{
      final barcode = await FlutterBarcodeScanner.scanBarcode("#ff6666", "Cancel", true, ScanMode.QR);
      if(!mounted) return;
      setState(() {
        this.barcode = barcode;
      });
    }on PlatformException{
      barcode = 'Failed to get platform version';
    }
  }
}
