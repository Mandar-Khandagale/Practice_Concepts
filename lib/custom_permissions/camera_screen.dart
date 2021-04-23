import 'dart:io';

import 'package:flutter/material.dart';
import 'package:form/responsive_pages/size_config.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:oktoast/oktoast.dart';

class CameraScreen extends StatefulWidget {
  @override
  _CameraScreenState createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen> {

  File _image;

  @override
  Widget build(BuildContext context) {
    return OKToast(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Camera Permission'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  height: 40 * SizeConfig.heightMultiplier,
                  width: 40 * SizeConfig.heightMultiplier,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: _image != null ? FileImage(File(_image.path)) :
                    NetworkImage('https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg')),
                  ),
                ),
              ),
             Expanded(
               flex: 1,
               child: IconButton(
                   iconSize: 15 * SizeConfig.imageSizeMultiplier,
                   icon: Icon(Icons.camera_alt),
                   onPressed: (){
                 checkPermissionCamera();
                   }
                   ),
             )
            ],
          ),
        ),
      ),
    );
  }

  checkPermissionCamera() async{
    var cameraStatus = await Permission.camera.status;
    print(cameraStatus);
    if(!cameraStatus.isGranted)
      await Permission.camera.request();
    if(await Permission.camera.isGranted)
      {
        _showerPicker(context);
      }else{
       showToast('Permission Denied', position: ToastPosition.bottom);
    }

  }

  _showerPicker(context){
    showModalBottomSheet(context: context, builder: (BuildContext con){
      return SafeArea(child: Container(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("Gallery"),
              onTap: (){
                _imgFromGallery();
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("Camera"),
              onTap: (){
                _imgFromCamera();
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      ));
    });
  }

  _imgFromCamera() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera,imageQuality: 60,);
    setState(() {
      _image = File(image.path);
    });
  }
  _imgFromGallery() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.gallery,imageQuality: 60,);
    setState(() {
      _image = File(image.path);
    });

  }

}
