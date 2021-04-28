import 'package:firebase_auth/firebase_auth.dart';
import 'package:form/firebase_demo/database_services.dart';
import 'package:form/firebase_demo/user.dart';

/// Firebase Authentication part

class AuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //create user obj based on firebase obj
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null ;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign_in anonymously
  Future signInAnon() async{
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign_in with email & pass
  Future signInWithEmailAndPass(String email, String pass) async{
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }
  //register with email & pass
  Future registerWithEmailAndPass(String email, String pass) async{
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;

      //create a new database for user with uid
      await DatabaseService(uid: user.uid).updateUserData('Update Name', email, 0);

      return _userFromFirebaseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign out
  Future signOut() async{
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      return null;
    }
  }



}