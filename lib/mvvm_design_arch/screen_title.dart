import 'package:flutter/material.dart';
import 'package:form/responsive_pages/size_config.dart';

class ScreenTitle extends StatelessWidget {
  final String text;
  ScreenTitle({this.text});
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      child: Text(
        text,
        style: TextStyle(fontSize: 6.0 * SizeConfig.textMultiplier,color: Colors.redAccent,
            fontWeight: FontWeight.w400),
      ),
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(seconds: 2),
      builder: (BuildContext context, double _opacity, Widget child){
        return Opacity(
          opacity: _opacity,
          child: Padding(
            padding: EdgeInsets.only(top: _opacity * 20),
            child: child,
          ),
        );
      },
    );
  }
}

