import 'package:flutter/material.dart';
import 'package:form/mvvm_design_arch/employee_detail.dart';
import 'package:form/mvvm_design_arch/employee_view_model.dart';
import 'package:form/mvvm_design_arch/screen_title.dart';
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
      body: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: Colors.brown[300],
          image: DecorationImage(
            image: AssetImage('assets/image/bg.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topLeft
          )
        ),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SizedBox(
                  height:60.0,
                child: ScreenTitle(text: "Employees List"),
              ),
            ),
            Expanded(
              flex: 4,
              child:employeeList(),),
          ],
        ),
      ),
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
                  physics: BouncingScrollPhysics(),
                    itemCount: data.employeeData.length,
                    itemBuilder: (context, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.lightBlue[100],
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: ListTile(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>
                                  EmployeeDetails(emp: data.employeeData[index],)));
                            },
                            leading: Hero(
                              tag: 'img-${data.employeeData[index].avatar}',
                              child: Container(
                                width: 50.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(image: NetworkImage(data.employeeData[index].avatar,),
                                  fit: BoxFit.fill),
                                ),
                              ),
                            ),
                            title: Text(data.employeeData[index].firstName+ ' ' +data.employeeData[index].lastName,
                            style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
                            subtitle: Text(data.employeeData[index].email,style: TextStyle(fontSize: 15.0),),
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
