import 'package:flutter/material.dart';
import 'package:form/model_classes/user_data_model_class.dart';
import 'package:form/rxdart_plugin/rxdart_user_bloc.dart';

class RxDartUserList extends StatefulWidget {
  @override
  _RxDartUserListState createState() => _RxDartUserListState();
}

class _RxDartUserListState extends State<RxDartUserList> {

  UserBloc userObj = UserBloc();

  @override
  void initState() {
    userObj.getData();
    super.initState();
  }
  @override
  void dispose() {
    userObj.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('RxDart Implementation'),
      ),
      body: StreamBuilder<List<UsersData>>(
          stream: userObj.userSubject.stream,
          builder: (context, snapshot){
            if(snapshot.data == null){
              return Center(child: CircularProgressIndicator(),);
            }else{
              List<UsersData> user = snapshot.data;
              return ListView.builder(
                  itemCount: user.length,
                  itemBuilder: (context, index){
                    if(user.isEmpty){
                      return Center(child: CircularProgressIndicator(),);
                    }else{
                      return Card(
                        elevation: 2.0,
                        child: ListTile(
                          leading: CircleAvatar(
                            child: Text(user[index].id.toString()),
                          ),
                          title: Text(user[index].title),
                        ),
                      );
                    }
                  });
            }
          }),
    );
  }
}
