import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';

class BarcodeGenerator extends StatefulWidget {
  @override
  _BarcodeGeneratorState createState() => _BarcodeGeneratorState();
}

class _BarcodeGeneratorState extends State<BarcodeGenerator> {

  TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Barcode Generator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                child: BarcodeWidget(
                  barcode: Barcode.qrCode(),
                  data: controller.text ?? 'NOT A SECRET MSG',
                  width: 200,
                  height: 200,
                  drawText: false,
                ),
              ),
              SizedBox(height: 40,),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                        controller: controller,
                        style: TextStyle(fontSize: 20.0),
                        decoration: InputDecoration(
                          hintText: "Enter data",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                      onPressed: (){
                        setState(() { });
                      },
                    child: Icon(Icons.done),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
