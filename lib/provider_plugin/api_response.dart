import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:form/model_classes/user_data_model_class.dart';
import 'package:http/http.dart' as http;

/// ChangeNotifier class to get the api response and to notify its listener

class ApiResponse extends ChangeNotifier{
  List<UsersData> userD;


getApiData() async{
  var response = await http.get('https://jsonplaceholder.typicode.com/todos');
  final jsonData = json.decode(response.body);
   userD = jsonData.map<UsersData>((jsonData)=>UsersData.fromJson(jsonData)).toList();
  if (response.statusCode==200) {
    notifyListeners();
    return userD;
  }
}

}