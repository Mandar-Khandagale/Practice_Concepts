import 'package:flutter/material.dart';
import 'package:form/firebase_demo/authenticate_services.dart';
import 'package:form/firebase_demo/database_services.dart';
import 'package:form/firebase_demo/loading_screen.dart';
import 'package:form/firebase_demo/update_user_info.dart';
import 'package:form/firebase_demo/user_info_model.dart';
import 'package:provider/provider.dart';

/// main screen of our app

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void updateUserInfo(){
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: UpdateUserInfo(),
        );
      });
    }

    return StreamProvider<List<UserInfo>>.value(
      value: DatabaseService().userInfo,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Home Page'),
          elevation: 0.0,
          backgroundColor: Colors.teal[500],
          actions: [
            IconButton(
                icon: Icon(Icons.logout),
                onPressed: () async{
                 await _auth.signOut();
                }
                ),
            FlatButton.icon(
                onPressed:(){
                  updateUserInfo();
                },
                icon: Icon(Icons.update),
                label: Text('Update')),
          ],
        ),
        backgroundColor: Colors.teal[100],
        body: UserInfoList(),
      ),
    );
  }
}

class UserInfoList extends StatefulWidget {
    @override
  _UserInfoListState createState() => _UserInfoListState();
}

class _UserInfoListState extends State<UserInfoList> {
  @override
  Widget build(BuildContext context) {
    final userInfo = Provider.of<List<UserInfo>>(context);
    return Container(
      child: ListView.builder(
        itemCount: userInfo?.length ?? 0,
        itemBuilder: (context, index){
          if(userInfo.isEmpty){
            return LoadingScreen();
          }
          else {
            return Padding(
              padding: const EdgeInsets.all(12.0),
              child: Card(
                color: Colors.teal[300],
                elevation: 2.0,
                child: ListTile(
                  isThreeLine: true,
                  title: Text(userInfo[index].name, style: TextStyle(
                      fontSize: 18.0, fontWeight: FontWeight.bold),),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(userInfo[index].email,
                        style: TextStyle(fontSize: 15.0),),
                      Text(userInfo[index].phoneNo.toString(),
                        style: TextStyle(fontSize: 15.0),),
                    ],
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

