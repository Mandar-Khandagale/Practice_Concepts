import 'package:flutter/cupertino.dart';
import 'package:form/model_classes/employee_model.dart';
import 'package:form/mvvm_design_arch/api_services.dart';

class EmployeeListViewModel extends ChangeNotifier{
  List<EmployeeModel> employeeData ;

  Future<List<EmployeeModel>> getData() async{
    final result = await ApiServices().fetchData();
    print('Employee List:-$result');
    employeeData = result;
    notifyListeners();
    return employeeData;
  }
}
