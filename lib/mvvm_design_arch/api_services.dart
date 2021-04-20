import 'dart:convert';

import 'package:form/model_classes/employee_model.dart';
import 'package:http/http.dart' as http;

class ApiServices{

  Future<List<EmployeeModel>> fetchData() async {
    final url = 'https://reqres.in/api/users?page=2';
    final response = await http.get(url);

    if(response.statusCode == 200){
      final jsonData = jsonDecode(response.body);
      Iterable list = jsonData['data'];
      print('mandadr$jsonData');
      return list.map<EmployeeModel>((data)=>EmployeeModel.fromJson(data)).toList();
    }else{
      throw Exception('Unable to load data');
    }


  }
}