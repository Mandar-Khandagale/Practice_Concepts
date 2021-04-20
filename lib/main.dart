import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:form/mvvm_design_arch/employee_view_model.dart';
import 'package:form/provider_plugin/api_response.dart';
import 'package:form/responsive_pages/size_config.dart';
import 'package:form/screens/home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
       DevicePreview(builder:(context)=> MyApp())
         // MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      MultiProvider(
      providers: [                //For Provider Package
        ChangeNotifierProvider(create: (context)=>ApiResponse(),),
        ChangeNotifierProvider(create: (context)=>EmployeeListViewModel(),),
      ],
      child:LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              SizeConfig().init(constraints, orientation);
              return MaterialApp(
                builder: DevicePreview.appBuilder,
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                    primarySwatch: Colors.yellow,
                  ),
                  home: HomeScreen()
                );
            }
          );
        }
      ),
    );
  }
}


