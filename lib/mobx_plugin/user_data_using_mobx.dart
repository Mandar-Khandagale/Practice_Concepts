import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:form/model_classes/user_data_model_class.dart';
import 'package:form/mobx_plugin/user_store_mobx.dart';
import 'package:mobx/mobx.dart';

/// Rendering List<UsersData> using Mobx Plugin for State Management

class MoBxUserList extends StatelessWidget {

  UserStore store = UserStore();
  MoBxUserList(){
    store.fetchUsers();
  }
  @override
  Widget build(BuildContext context) {
    final data = store.userListFuture;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Data using Mobx'),
      ),
      body: Container(
        child: Observer(
            builder: (context) {
          if(data.status == FutureStatus.pending){
            return Center(child: CircularProgressIndicator(),);
          }else if(data.status == FutureStatus.fulfilled){
            final List<UsersData> post = data.result;
            return ListView.builder(
                itemCount: post.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 5.0,
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: Colors.yellow,
                            child: Text(post[index].id.toString(),style: TextStyle(color: Colors.red,fontSize: 20.0,fontWeight: FontWeight.bold),),
                          ),
                          title: Text(post[index].title),
                        ),
                      ),
                    ),
                  );
                });
          }else{
            return Center(child: Text('Hello'),);
          }
        }),
      ),
    );
  }
}


