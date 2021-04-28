import 'package:flutter/material.dart';
import 'package:form/firebase_demo/authenticate.dart';
import 'package:form/firebase_demo/home_screen.dart';
import 'package:form/firebase_demo/user.dart';
import 'package:provider/provider.dart';

///to check whether the user is logged in or not

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    if(user == null){
      return Authenticate();
    }else{
      return Home();
    }
  }
}
