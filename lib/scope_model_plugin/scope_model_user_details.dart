import 'package:flutter/material.dart';
import 'package:form/scope_model_plugin/scope_model_viewmodel.dart';
import 'package:scoped_model/scoped_model.dart';

class ScopeModelUserView extends StatefulWidget {
  @override
  _ScopeModelUserViewState createState() => _ScopeModelUserViewState();
}

class _ScopeModelUserViewState extends State<ScopeModelUserView> {

  EmployeeDataModel obj = EmployeeDataModel();
   @override
  Widget build(BuildContext context) {
    return ScopedModel<EmployeeDataModel>(
      model: obj,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Scope Model Implementation'),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.stream),
          onPressed: (){
           obj.getData();
          },
        ),
        body: ScopedModelDescendant<EmployeeDataModel>(builder: (context, child, model){
          print('mandardaea;-$model');
          if(model.employeeData.isNotEmpty){
            return ListView.builder(
                itemCount: model.employeeData.length,
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
                        image: DecorationImage(image: NetworkImage(model.employeeData[index].avatar,),
                            fit: BoxFit.fill),
                      ),
                    ),
                    title: Text(model.employeeData[index].firstName+ ' ' +model.employeeData[index].lastName),
                    subtitle: Text(model.employeeData[index].email),
                  ),
                ),
              );
            });
          }else{
            return Center(child: Text('Click on below button'),);
          }
        }),
      ),
    );
  }
}
