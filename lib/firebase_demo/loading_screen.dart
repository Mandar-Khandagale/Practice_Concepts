import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// loading screen to show data is loading

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.teal[100],
        child: Center(
          child: SpinKitPouringHourglass(
            color: Colors.teal,
          ),
        ));
  }
}
