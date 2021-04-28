import 'package:flutter/material.dart';
import 'package:form/firebase_demo/authenticate_services.dart';
import 'package:form/firebase_demo/constants.dart';
import 'package:form/firebase_demo/loading_screen.dart';
import 'package:oktoast/oktoast.dart';

/// registered user can sign-in

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool showPass = true;
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    pass.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return  OKToast(
      child: isLoading ? LoadingScreen() : Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Sign In '),
          elevation: 0.0,
          backgroundColor: Colors.teal[500],
        ),
        backgroundColor: Colors.teal[100],
        body: Container(
          padding: EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: textInputDecoration.copyWith(hintText: 'Email Address', prefixIcon: Icon(Icons.email, color: Colors.black,)),
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
                  controller: pass,
                  obscureText: showPass,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: textInputDecoration.copyWith(hintText: 'Password',
                    prefixIcon: Icon(Icons.lock, color: Colors.black,),
                    suffixIcon: IconButton(
                    color: Colors.black,
                    icon: Icon(showPass ? Icons.visibility : Icons.visibility_off),
                    onPressed: (){
                      setState(() {
                        if(showPass == true){showPass = false;}
                        else{ showPass = true;}
                      });
                    },
                  ),),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Required';
                    } else if (value.length < 6) {
                      return 'Password should be more than 6 characters';
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(height: 20.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                        onPressed:() async{
                          if(_formKey.currentState.validate()){
                            setState(() {
                              isLoading = true;
                            });
                            dynamic result = await _auth.signInWithEmailAndPass(email.text, pass.text);
                            if(result == null){
                              setState(() {
                                isLoading = false;
                              });
                              showToast('Enter Valid Email or Password',position: ToastPosition.bottom);
                            }
                          }
                        },
                      color: Colors.green,
                      child: Text('Sign In'),
                    ),
                    RaisedButton(
                        onPressed:() {
                          widget.toggleView();
                        },
                      color: Colors.green,
                      child: Text('Register'),
                    ),
                  ],
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
