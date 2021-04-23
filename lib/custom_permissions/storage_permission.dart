import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class StoragePermission extends StatefulWidget {
  @override
  _StoragePermissionState createState() => _StoragePermissionState();
}

class _StoragePermissionState extends State<StoragePermission> {
  final Dio dio = Dio();
  bool loading = false;
  double progress = 0;
  TextEditingController nameController = TextEditingController();
  TextEditingController urlController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text('Storage Permission'),
          ),
          body: Center(
            child:Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextField(
                    controller: urlController,
                    decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(color: Colors.green,width: 1.5),),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green,width: 1.5),
                          borderRadius: BorderRadius.circular(30),),
                      hintText: 'Enter URL'
                    ),
                  ),
                  SizedBox(height: 20,),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide(color: Colors.green,width: 1.5),),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.green,width: 1.5),
                        borderRadius: BorderRadius.circular(30),),
                        hintText: 'Save Name',
                    ),
                  ),
                  SizedBox(height: 20,),
                  loading
                      ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: LinearProgressIndicator(
                      backgroundColor: Colors.green,
                      minHeight: 5,
                      value: progress,
                    ),
                  )
                      : RaisedButton.icon(
                      icon: Icon(
                        Icons.download_rounded,
                        color: Colors.white,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      color: Colors.green,
                      onPressed: () async{
                        downloadFile(urlController.text,nameController.text);
                      },
                      padding: const EdgeInsets.all(10),
                      label: Text(
                        "Download  Image",
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      )),
                ],
              ),
            ),
          )),
    );
  }

 Future<dynamic> downloadFile(String url, String name) async{
    setState(() {
      loading = true;
      progress = 0;
    });

    bool downloaded = await saveFile( "$url",'$name.jpg');
    if(downloaded){
      showToast('File Downloaded',position: ToastPosition.bottom);
    }else{
      showToast('File Not Downloaded',position: ToastPosition.bottom);
    }

    setState(() {
      loading = false;
    });
  }

  Future<bool> saveFile(String url, String fileName) async{
    Directory directory;
    try{
      if(Platform.isAndroid){
        if(await _requestPermission(Permission.storage)){
          directory = await getExternalStorageDirectory();
          print(directory.path);
          String newPath = "";
          List<String> paths = directory.path.split("/");
          for(int i = 1; 1< paths.length; i++){
            String folder = paths[i];
            if(folder != "Android"){
              newPath += "/" + folder;
            }else{
              break;
            }
          }
          newPath = newPath + "/ToDo_form";
          directory = Directory(newPath);
        }else {
          return false;
        }
      }
      File saveFile = File(directory.path + "/$fileName");
      if(!await directory.exists()){
        await directory.create(recursive: true);
      }
      if(await directory.exists()){
        await dio.download(url, saveFile.path,onReceiveProgress: (value1,value2){
          setState(() {
            progress = value1/value2;
          });
        });
        return true;
      }
      return false;
    }catch(e){
      print(e);
      return false;
    }
  }

  Future<bool> _requestPermission(Permission permission) async{
    if(await permission.isGranted){
      return true;
    }else{
      var result = await permission.request();
      if(result == PermissionStatus.granted){
        return true;
      }
    }
    return false;
  }

}
