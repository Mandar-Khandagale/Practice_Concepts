import 'package:device_preview/device_preview.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:form/custom_permissions/permissions.dart';
import 'package:form/firebase_demo/authenticate_services.dart';
import 'package:form/firebase_demo/user.dart';
import 'package:form/firebase_demo/wrapper.dart';
import 'package:form/live_location/user_live_location.dart';
import 'package:form/mvvm_design_arch/employee_view_model.dart';
import 'package:form/notifications_flutter/firebase_push_notification.dart';
import 'package:form/notifications_flutter/local_notification.dart';
import 'package:form/provider_plugin/api_response.dart';
import 'package:form/responsive_pages/size_config.dart';
import 'package:form/screens/home_screen.dart';
import 'package:provider/provider.dart';


void main() {
  runApp(EasyLocalization(
             child: MyApp(),
             path: 'lang',
             saveLocale: true,
             supportedLocales: [
               Locale('en','EN'),
               Locale('mr','IN'),
               Locale('hi','IN'),
             ],
           ),

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
              SizeConfig().init(constraints, orientation);
              return StreamProvider<User>.value(
                value: AuthService().user,
                child: MaterialApp(
                  builder: DevicePreview.appBuilder,
                    debugShowCheckedModeBanner: false,
                    theme: ThemeData(
                      primarySwatch: Colors.yellow,
                    ),
                  localizationsDelegates: context.localizationDelegates,
                  supportedLocales: context.supportedLocales,
                  locale: context.locale,
                  //home: HomeScreen(),//for other implementation
                  //home:Wrapper(), //for firebase implementation
                  home: LocalNotification(),  // for Local Notification
                  //home: PushNotification(),// for  Firebase Push Notification
                  ),
              );
            }
          );
        }
      ),
    );
  }
}


