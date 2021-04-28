import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:form/custom_permissions/permissions.dart';
import 'package:form/firebase_demo/authenticate_services.dart';
import 'package:form/firebase_demo/user.dart';
import 'package:form/firebase_demo/wrapper.dart';
import 'package:form/mvvm_design_arch/employee_view_model.dart';
import 'package:form/provider_plugin/api_response.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(
       DevicePreview(
           enabled: false,
           builder:(context)=> MyApp())
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
        ChangeNotifierProvider(create: (context)=>PermissionsStatus()),
      ],
      child:LayoutBuilder(
        builder: (context, constraints) {
          return OrientationBuilder(
            builder: (context, orientation) {
              //SizeConfig().init(constraints, orientation);
              return StreamProvider<User>.value(
                value: AuthService().user,
                child: MaterialApp(
                  builder: DevicePreview.appBuilder,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      primarySwatch: Colors.yellow,
                    ),
                  //home: HomeScreen(),//for other implementation
                  home:Wrapper(), //for firebase implementation
                  ),
              );
            }
          );
        }
      ),
    );
  }
}


