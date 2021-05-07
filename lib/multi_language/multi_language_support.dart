import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:shake/shake.dart';

class MultiLang extends StatefulWidget {
  @override
  _MultiLangState createState() => _MultiLangState();
}

class _MultiLangState extends State<MultiLang> {

  static List<String> quotes = [
    'Your future depends on your dreams, so go to sleep',
    'When you lie down, you will not be afraid. Your sleep will be sweet',
    'Each night, when I go to sleep, I die. And the next morning, when I wake up, I’m reborn'
  ];
  String quote = quotes.first;
  ShakeDetector detector;

  @override
  void initState() {
    detector = ShakeDetector.autoStart(onPhoneShake: (){
      final newQuote = (List.of(quotes)..remove(quote)..shuffle()).first;
      setState(() {
        this.quote = newQuote;
      });
    });
    super.initState();
  }
  @override
  void dispose() {
    detector.stopListening();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 5.0,
        centerTitle: true,
        title: Text('title'.tr().toString()),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('"$quote"',style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500,
                  color: Colors.orange),textAlign: TextAlign.center,),
              SizedBox(height: 50.0,),
              Text('home'.tr().toString(),style: TextStyle(fontSize: 40.0,color: Colors.white),
                textAlign: TextAlign.center,),
              SizedBox(height: 50.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                      onPressed:(){
                        setState(() {
                          EasyLocalization.of(context).locale = Locale('en','EN');
                        });
                      },
                    child: Text('English'),
                    color: Colors.green,
                  ),
                  RaisedButton(
                    onPressed:(){
                      setState(() {
                        EasyLocalization.of(context).locale = Locale('mr','IN');
                      });
                    },
                    child: Text('Marathi'),
                    color: Colors.green,
                  ),
                  RaisedButton(
                    onPressed:(){
                      setState(() {
                        EasyLocalization.of(context).locale = Locale('hi','IN');
                      });
                    },
                    child: Text('Hindi'),
                    color: Colors.green,
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
