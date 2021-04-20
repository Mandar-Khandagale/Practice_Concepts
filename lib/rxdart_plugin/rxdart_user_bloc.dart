import 'dart:convert';

import 'package:form/model_classes/user_data_model_class.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:dio/dio.dart';

class UserBloc{
  Dio _dio = Dio();
  List<UsersData> userData = List();

  final BehaviorSubject<List<UsersData>> userSubject = BehaviorSubject<List<UsersData>>();

  getData() async{
    var response = await _dio.get('https://jsonplaceholder.typicode.com/todos');
    print('manan-${response.data}');
    List<dynamic> body = response.data;
    if (response.statusCode==200) {
      for (var data in body) {
        userData.add(UsersData.fromJson(data));
      }
      // var jsonData = json.decode(body);
      // userData = jsonData.map<UsersData>((jsonData)=>UsersData.fromJson(jsonData)).toList();
      print('shsg-$userData');
      userSubject.add(userData);
    }else{
      print('Error in URl');
    }

  }

  void dispose(){
    userSubject.close();
  }
}