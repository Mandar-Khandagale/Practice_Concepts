import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:form/provider_plugin/api_response.dart';
import 'package:provider/provider.dart';

/// Rendering List<UsersData> using Provider plugin for State Management

class ListUserData extends StatefulWidget {
  @override
  _ListUserDataState createState() => _ListUserDataState();
}

class _ListUserDataState extends State<ListUserData> {
  @override
  void initState() {
    // var apiResponse = Provider.of<ApiResponse>(context,listen: false);
    // apiResponse.getApiData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<ApiResponse>(context).getApiData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Data using Provider'),
      ),
      body: Container(
        child: Consumer<ApiResponse>(
          builder: (context, data, child) {
            if(data.userD == null){
              return Center(child: CircularProgressIndicator(),);
            }else{
              return ListView.builder(
                  itemCount: 50,
                  physics: BouncingScrollPhysics(),
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
                          child: Text(data.userD[index].id.toString(),style: TextStyle(color: Colors.red,fontSize: 20.0,fontWeight: FontWeight.bold),),
                        ),
                        title: Text(data.userD[index].title),
                      ),
                    ),
                  ),
                );
              });
            }
          },
        ),
      ),
    );
  }
}
