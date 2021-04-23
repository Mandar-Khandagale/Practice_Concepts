import 'package:flutter/material.dart';
import 'package:location/location.dart';

class PermissionsStatus extends ChangeNotifier{

  PermissionStatus _permissionStatus;
  Location location = Location();

  requestLocationPermission() async {
    if (_permissionStatus != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult = await location.requestPermission();
        _permissionStatus = permissionRequestedResult;
        notifyListeners();
    }
  }
}