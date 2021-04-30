import 'package:flutter/material.dart';
import 'package:form/model_classes/employee_model.dart';

class EmployeeDetails extends StatelessWidget {

  EmployeeModel emp;
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
            height: 360,
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
            ),
          ),
          SizedBox(height: 30.0,),
          ListTile(
            title: Text(emp.firstName+' '+emp.lastName,
            style: TextStyle(fontSize: 40.0,color: Colors.black),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10.0),
                Text(emp.email,
                  style: TextStyle(fontSize: 20.0),),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
