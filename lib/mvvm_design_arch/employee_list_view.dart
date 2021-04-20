import 'package:flutter/material.dart';
import 'package:form/mvvm_design_arch/employee_view_model.dart';
import 'package:provider/provider.dart';

class EmployeeListView extends StatefulWidget {
  @override
  _EmployeeListViewState createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {

  @override
  void initState() {
    Provider.of<EmployeeListViewModel>(context,listen: false).getData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee List'),
        centerTitle: true,
      ),
      body: employeeList(),
    );
  }

  employeeList() {
    return Container(
      child: Consumer<EmployeeListViewModel>(
          builder: (context, data, child){
            print("zxcv:-${data.employeeData}");
            if(data.employeeData == null){
              return Center(child: CircularProgressIndicator(),);
            }
            else{
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
                    itemCount: data.employeeData.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 2.0,
                          child: ListTile(
                            leading: Container(
                              width: 50.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(image: NetworkImage(data.employeeData[index].avatar,),
                                fit: BoxFit.fill),
                              ),
                            ),
                            title: Text(data.employeeData[index].firstName+ ' ' +data.employeeData[index].lastName),
                            subtitle: Text(data.employeeData[index].email),
                          ),
                        ),
                      );
                    }),
              );
            }
          }),
    );
  }
}
