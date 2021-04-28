import 'package:flutter/material.dart';
import 'package:form/firebase_demo/register.dart';
import 'package:form/firebase_demo/sign_in.dart';

///to toggle between sign-in and register

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() {
      showSignIn =!showSignIn;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView : toggleView);
    }else{
      return Register(toggleView : toggleView);
    }
  }
}
