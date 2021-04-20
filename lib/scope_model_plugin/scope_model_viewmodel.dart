import 'package:form/model_classes/employee_model.dart';
import 'package:form/mvvm_design_arch/api_services.dart';
import 'package:scoped_model/scoped_model.dart';

class EmployeeDataModel extends Model{

  List<EmployeeModel> employeeData= List();

   getData() async{
     final result = await ApiServices().fetchData();
     print('Employee List:-$result');
     employeeData = result;
     notifyListeners();
  }


}