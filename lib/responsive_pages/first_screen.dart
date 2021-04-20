import 'package:flutter/material.dart';
import 'package:form/responsive_pages/size_config.dart';

class FirstResponsivePage extends StatefulWidget {
  @override
  _FirstResponsivePageState createState() => _FirstResponsivePageState();
}

class _FirstResponsivePageState extends State<FirstResponsivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Responsive Page',style: TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier),),
      ),
      body: SafeArea(
        bottom: false,
        left: true,
        right: true,
        top: false,
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 4,
                child: Align(
                  alignment: Alignment.center,
                  child: homeLayout(),
                )),
            Expanded(flex: 1, child: buttonLayout()),
          ],
        ),
      ),
    );
  }

  homeLayout() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Padding(
              padding:  EdgeInsets.only(top: 1 * SizeConfig.heightMultiplier),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: FittedBox(
                  child: Text(
                    'Welcome To \nMy Page',
                    style: TextStyle(fontSize: 3 * SizeConfig.textMultiplier),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 1 * SizeConfig.heightMultiplier),
                child: Image.asset("assets/image/flutter_logo.png"),
              )),
          Expanded(
            flex: 1,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 2 * SizeConfig.heightMultiplier),
                child: FittedBox(
                  child: Text(
                    'Anyone can join the millions of \nmembers in our community to learn \ncutting-edge skills.',
                    style: TextStyle(fontSize: 2.4 * SizeConfig.textMultiplier),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  buttonLayout() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
      padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          color: Colors.lightBlueAccent,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 1,
                child: Icon(Icons.chevron_left,size: 8 * SizeConfig.imageSizeMultiplier,)
            ),
            Text('NEXT PAGE',style: TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier),),
            Expanded(
                flex: 1,
                child: Icon(Icons.chevron_right,size: 8 * SizeConfig.imageSizeMultiplier,)
            ),
          ],
        ),
      ),
    );
  }
}
