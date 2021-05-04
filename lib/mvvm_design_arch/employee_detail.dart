import 'package:flutter/material.dart';
import 'package:form/model_classes/employee_model.dart';
import 'package:form/mvvm_design_arch/favourite_button.dart';
import 'package:form/responsive_pages/size_config.dart';

class EmployeeDetails extends StatelessWidget {

  final EmployeeModel emp;
   EmployeeDetails({this.emp});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,

      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Hero(
            tag: 'img-${emp.avatar}',
            child: Image.network(emp.avatar,
            height: 46 * SizeConfig.heightMultiplier,
              width: double.infinity,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          SizedBox(height: 30.0,),
          ListTile(
            title: Text(emp.firstName+' '+emp.lastName,
            style: TextStyle(fontSize: 5 * SizeConfig.textMultiplier,color: Colors.black),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 1.5 * SizeConfig.textMultiplier),
                Text(emp.email,
                  style: TextStyle(fontSize: 2.5 * SizeConfig.textMultiplier),),
              ],
            ),
            trailing: FavouriteButton(),
          ),
        ],
      ),
    );
  }
}
