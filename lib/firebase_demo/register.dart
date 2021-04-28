import 'package:flutter/material.dart';
import 'package:form/firebase_demo/authenticate_services.dart';
import 'package:form/firebase_demo/constants.dart';
import 'package:form/firebase_demo/loading_screen.dart';
import 'package:oktoast/oktoast.dart';

/// for user registration

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool showPass = true;
  bool isLoading = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose();
    pass.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: isLoading ? LoadingScreen() : Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Registration'),
          elevation: 0.0,
          backgroundColor: Colors.teal[500],
          actions: [
            FlatButton.icon(
                onPressed: (){
                  widget.toggleView();
                },
                icon: Icon(Icons.person), label: Text('Sign-In')),
          ],
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
                RaisedButton(
                    onPressed:() async{
                      if(_formKey.currentState.validate()){
                        setState(() {
                          isLoading = true;
                        });
                        dynamic result = await _auth.registerWithEmailAndPass(email.text, pass.text);
                        if(result == null){
                          setState(() {
                            isLoading = false;
                          });
                          showToast('Enter valid Email',position: ToastPosition.bottom);
                        }
                      }
                },
                  color: Colors.green,
                  child: Text('Register'),
                ),
              ],
            ),

          ),
        ),
      ),
    );
  }
}
