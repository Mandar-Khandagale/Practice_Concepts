import 'package:flutter/material.dart';
import 'package:form/firebase_demo/constants.dart';
import 'package:form/firebase_demo/database_services.dart';
import 'package:form/firebase_demo/loading_screen.dart';
import 'package:form/firebase_demo/user.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';

/// to update signed users info

class UpdateUserInfo extends StatefulWidget {
  @override
  _UpdateUserInfoState createState() => _UpdateUserInfoState();
}

class _UpdateUserInfoState extends State<UpdateUserInfo> {

  final _formKey = GlobalKey<FormState>();

   String name1;
   String email1;
   int phone;

  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return OKToast(
      child: StreamBuilder<UserData>(
        stream: DatabaseService(uid: user.uid).userData,
        builder: (context, snapshot) {
          if(snapshot.hasData){
            UserData userData = snapshot.data;
            return Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  Text('Update User Info:-',style: TextStyle(fontSize: 18.0),),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.name,
                    onChanged: (val){
                      setState(() {
                        name1 = val;
                      });
                    },
                    keyboardType: TextInputType.name,
                    decoration: textInputDecoration.copyWith(hintText: 'Name',
                      prefixIcon: Icon(Icons.person, color: Colors.black,),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Required';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.email,
                    onChanged: (val){
                      setState(() {
                        email1 = val;
                      });
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: textInputDecoration.copyWith(hintText:'Email', prefixIcon: Icon(Icons.email, color: Colors.black,)),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Required';
                      } else if (!RegExp(
                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value)) {
                        return 'Invalid Email';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0,),
                  TextFormField(
                    initialValue: userData.phoneNo.toString(),
                    onChanged: (val){
                      setState(() {
                        phone = int.parse(val);
                      });
                    },
                    keyboardType: TextInputType.phone,
                    decoration: textInputDecoration.copyWith(hintText:'Phone No.',
                      prefixIcon: Icon(Icons.phone_android, color: Colors.black,),
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Required';
                      } else if (value.length < 10 || value.length >10 ) {
                        return 'PhoneNo should be of 10 characters';
                      } else {
                        return null;
                      }
                    },
                  ),
                  SizedBox(height: 20.0,),
                  RaisedButton(
                    onPressed:() async{
                      if(_formKey.currentState.validate()){
                        await DatabaseService(uid: user.uid).updateUserData(
                            name1 ?? snapshot.data.name,
                            email1 ?? snapshot.data.email,
                            phone ?? snapshot.data.phoneNo
                        );
                        Navigator.pop(context);
                      }
                    },
                    color: Colors.green,
                    child: Text('Update'),
                  ),
                ],
              ),
            );
          }else{
            return LoadingScreen();
          }
        }
      ),
    );
  }
}
