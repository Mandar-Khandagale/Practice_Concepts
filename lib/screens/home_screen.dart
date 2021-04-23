import 'package:flutter/material.dart';
import 'package:form/custom_permissions/camera_screen.dart';
import 'package:form/custom_permissions/permissions.dart';
import 'package:form/custom_permissions/storage_permission.dart';
import 'package:form/mvvm_design_arch/employee_list_view.dart';
import 'package:form/responsive_pages/first_screen.dart';
import 'package:form/responsive_pages/size_config.dart';
import 'package:form/rxdart_plugin/userlist_rxdart.dart';
import 'package:form/scope_model_plugin/scope_model_user_details.dart';
import 'package:form/sqflite/second_screen.dart';
import 'dart:async';
import 'package:form/sqflite/note_model_class.dart';
import 'package:form/provider_plugin/user_data_screen.dart';
import 'package:form/mobx_plugin/user_data_using_mobx.dart';
import 'package:form/sqflite/database_helper.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';
//import 'package:location/location.dart';

/// Main Screen where List<Note> appear to the User

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  // PermissionStatus _permissionStatus;
  // Location location = Location();

  // Future<void> _checkPermissions() async {
  //   final PermissionStatus permissionGrantedResult = await location.hasPermission();
  //   setState(() {
  //     _permissionStatus = permissionGrantedResult;
  //   });
  //   print('Permission Status:-$_permissionStatus');
  // }
  //
  // Future<void> _requestPermission() async {
  //   if (_permissionStatus != PermissionStatus.granted) {
  //     final PermissionStatus permissionRequestedResult =
  //     await location.requestPermission();
  //     setState(() {
  //       _permissionStatus = permissionRequestedResult;
  //     });
  //   }
  // }

  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  int count =0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   Provider.of<PermissionsStatus>(context,listen: false).requestLocationPermission();
  }
  @override
  Widget build(BuildContext context) {
    if(noteList == null){
      noteList = List<Note>();
      updateListView();
    }
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Notes',style: TextStyle(fontSize: 3.5 * SizeConfig.textMultiplier),),
        leading: IconButton(
          icon: Icon(Icons.camera,size: 4 * SizeConfig.heightMultiplier,color: Colors.black,),
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>CameraScreen()));
          },
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.skip_next_sharp,size: 4 * SizeConfig.heightMultiplier,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>ListUserData()));
              }
              ),
          IconButton(
              icon: Icon(Icons.next_plan_outlined,size: 4 * SizeConfig.heightMultiplier,),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MoBxUserList()));
              }
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        left: true,
        right: true,
        top: false,
        child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            getList(),
            Padding(
              padding: EdgeInsets.all(2 * SizeConfig.heightMultiplier),
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(flex:1,child:  raisedButton("MVVM",EmployeeListView()),),
                SizedBox(width: 4 *SizeConfig.widthMultiplier,),
                Expanded(flex: 1,child:raisedButton('RxDart',RxDartUserList()),),
                SizedBox(width: 4 *SizeConfig.widthMultiplier,),
                Expanded(flex: 1, child: raisedButton('Scope Model',ScopeModelUserView()),),
                SizedBox(width: 4 *SizeConfig.widthMultiplier,),
                Expanded(flex: 1, child: raisedButton('Permission',StoragePermission()),),

              ],
                ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        width: 9 * SizeConfig.heightMultiplier,
        padding: EdgeInsets.only(bottom: 5 * SizeConfig.heightMultiplier),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              heroTag: 'bt1',
              child: Icon(Icons.add),
              onPressed: () async{
               bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen(Note('','',''),'Add Note')));
               if(result == true){
                 updateListView();
               }
               },
            ),
            SizedBox(height: 10.0,),
            FloatingActionButton(
                heroTag: 'bt2',
              child: Icon(Icons.next_plan_outlined),
                onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>FirstResponsivePage()));
            }),
            SizedBox(height: 10.0,),
            // FloatingActionButton(
            //     heroTag: 'bt3',
            //     child: Icon(Icons.perm_device_info),
            //     onPressed: (){
            //      _checkPermissions();
            //     }),
          ],
        ),
      ),
    );
  }

  getList() {
    return Expanded(
      child: ListView.builder(
          itemCount: count,
          physics: BouncingScrollPhysics(),
          itemBuilder: (context, index){
        return Padding(
          padding:  EdgeInsets.all(3 * SizeConfig.widthMultiplier),
          child: Card(
            elevation: 2.0,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: ListTile(
                onTap: () async{
                  bool result = await Navigator.push(context, MaterialPageRoute(builder: (context)=>SecondScreen(noteList[index], 'Edit Note')));
                  if(result == true){
                    updateListView();
                  }
                  },
                leading: CircleAvatar(
                  backgroundColor: Colors.yellow,
                  child: Icon(Icons.arrow_right,size: 30.0,color: Colors.red,),
                ),
                title: Text(noteList[index].title,style: TextStyle(fontSize: 2.2 * SizeConfig.textMultiplier,)),
                subtitle: Text(noteList[index].description,style: TextStyle(fontSize: 1.8 * SizeConfig.textMultiplier,)),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Column(
                    children: [
                      Text(noteList[index].date,style: TextStyle(fontSize: 2.1 * SizeConfig.textMultiplier,)),
                      IconButton(
                        icon: Icon(Icons.delete,size: 6 * SizeConfig.widthMultiplier,),
                        onPressed: (){
                          _delete(context, noteList[index]);
                        }
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  raisedButton(String title, Widget page){
    return Container(
      height: 5 * SizeConfig.heightMultiplier,
      width: 25* SizeConfig.widthMultiplier,
      child: RaisedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>page));
          },
        child: Text(title,style: TextStyle(fontSize: 1.6 * SizeConfig.textMultiplier,)),
      ),
    );
  }

  void _delete(BuildContext context, Note note) async {

    int result = await databaseHelper.deleteNote(note.id);
    if (result != 0) {
      _showSnackBar(context, 'Note Deleted Successfully');
      updateListView();
    }
  }

  void _showSnackBar(BuildContext context, String message) {

    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  void updateListView() {

    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }

}





