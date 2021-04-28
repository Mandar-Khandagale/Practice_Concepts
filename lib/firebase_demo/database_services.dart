import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:form/firebase_demo/user.dart';
import 'package:form/firebase_demo/user_info_model.dart';

/// firestore database part

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection references
  final CollectionReference userInfoCollection = Firestore.instance.collection('usersInfo');

  Future updateUserData(String name, String email, int phoneNo,) async{
    return await userInfoCollection.document(uid).setData({
      'name' : name,
      'email' : email,
      'phoneNo' : phoneNo,
    });
  }

  // add data
  Future addData(String name, String email, int phoneNo,) async{
    return await userInfoCollection.document(uid).updateData({
      'name' : name,
      'email' : email,
      'phoneNo' : phoneNo,
    });
  }
   // delete data
  Future deleteData() async{
    return await userInfoCollection.document(uid).delete();
  }


  //get userInfo stream
  Stream<List<UserInfo>> get userInfo {
    return userInfoCollection.snapshots().map(_userInfoListFromSnapshot);
  }

  //userInfo list from database
  List<UserInfo> _userInfoListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return UserInfo(
        name: doc.data['name'] ?? '',
        email: doc.data['email'] ?? '',
        phoneNo: doc.data['phoneNo'] ?? 0,
      );
    }).toList();
  }


  // user document stream
  Stream<UserData> get userData {
    return userInfoCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  }

  //user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data['name'],
      email: snapshot.data['email'],
      phoneNo: snapshot.data['phoneNo'],
    );
  }

}