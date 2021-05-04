import 'package:flutter/material.dart';
import 'package:form/model_classes/employee_model.dart';
import 'package:form/mvvm_design_arch/employee_detail.dart';
import 'package:form/mvvm_design_arch/employee_view_model.dart';
import 'package:form/mvvm_design_arch/screen_title.dart';
import 'package:provider/provider.dart';

class EmployeeListView extends StatefulWidget {
  @override
  _EmployeeListViewState createState() => _EmployeeListViewState();
}

class _EmployeeListViewState extends State<EmployeeListView> {

  GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  List<Widget> _empList = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
    var providerValue = await Provider.of<EmployeeListViewModel>(context,listen: false).getData();
      _addEmp(providerValue);
    });
  }

  void _addEmp(List<EmployeeModel> empList){

    Future future = Future((){});

    empList.forEach((EmployeeModel data) {
      future = future.then((value) {
        return Future.delayed(Duration(milliseconds: 200),(){
          _empList.add(_buildTile(data));
          _listKey.currentState.insertItem(_empList.length-1);
        });
      });
    });
  }

  Widget _buildTile(EmployeeModel emp) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.lightBlue[100],
        borderRadius: BorderRadius.circular(20.0),
      ),
      child:
      ListTile(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>
              EmployeeDetails(emp: emp,)));
        },
        leading: Hero(
          tag: 'img-${emp.avatar}',
          child: Container(
            width: 50.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: NetworkImage(emp.avatar,),
                  fit: BoxFit.fill),
            ),
          ),
        ),
        title: Text(emp.firstName+ ' ' +emp.lastName,
          style: TextStyle(fontSize: 20.0,fontWeight: FontWeight.w500),),
        subtitle: Text(emp.email,style: TextStyle(fontSize: 15.0),),
      ),
    );
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

  Tween<Offset> _offset = Tween(begin: Offset(1,0), end: Offset(0,0));

  employeeList() {
    return Container(
      child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedList(
                  key: _listKey,
                  physics: BouncingScrollPhysics(),
                    initialItemCount: _empList.length,
                    itemBuilder: (context, index, animation){
                      return SlideTransition(
                        position: animation.drive(_offset),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: _empList[index],
                        ),
                      );
                    }),
              ),
    );
  }
}
