import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class UserLiveLocation extends StatefulWidget {
  @override
  _UserLiveLocationState createState() => _UserLiveLocationState();
}

class _UserLiveLocationState extends State<UserLiveLocation> {

  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  static final CameraPosition initialPosition = CameraPosition(
    target: LatLng(19.229500,72.860320),
    zoom: 15,
  );

  @override
  void dispose() {
    if(_locationSubscription != null){
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('User Live Location'),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: initialPosition,
        markers: Set.of((marker != null)? [marker] : []),
        circles: Set.of((circle != null) ? [circle] : []),
        onMapCreated: (GoogleMapController controller){
          _controller = controller;
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.my_location),
        onPressed: (){
          getCurrentLocation();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void getCurrentLocation() async{
    try{

      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();
      
      updateMarkerAndCircle(location, imageData);

      if(_locationSubscription != null){
        _locationSubscription.cancel();
      }

      _locationSubscription = _locationTracker.onLocationChanged.listen((newLocalData) {
        if(_controller != null){
          _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
            bearing: 192.8334901395799,
            target: LatLng(newLocalData.latitude , newLocalData.longitude),
            tilt: 0,
            zoom: 18.00,
          )));
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });

    }on PlatformException catch (e){
      if(e.code == 'PERMISSION_DENIED'){
        Fluttertoast.showToast(
          msg: "PERMISSION DENIED",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.SNACKBAR,
        );
      }
    }
  }

  Future<Uint8List> getMarker() async{
    ByteData byteData = await DefaultAssetBundle.of(context).load('assets/image/person_icon.png');
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocation, Uint8List imageData) {

    LatLng latLng = LatLng(newLocation.latitude,newLocation.longitude);
    setState(() {
      marker = Marker(
        markerId: MarkerId('home'),
        position: latLng,
        rotation: newLocation.heading,
        draggable: false,
        zIndex: 2,
        flat: true,
        anchor: Offset(0.5,0.5),
        icon: BitmapDescriptor.fromBytes(imageData),
      );
      circle = Circle(
        circleId: CircleId('person'),
        radius: newLocation.accuracy,
        zIndex: 1,
        strokeColor: Colors.blue,
        center: latLng,
        fillColor: Colors.blue.withAlpha(70),
      );
    });

  }


}
