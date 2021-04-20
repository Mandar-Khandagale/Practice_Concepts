import 'dart:convert';
import 'package:form/model_classes/user_data_model_class.dart';
import 'package:http/http.dart' as http;

/// NetworkServices class to get the api response

class NetworkServices{
  List<UsersData> userData = List();

   Future getData(String url) async{
    final response = await http.get(url);
    if(response.statusCode == 200){
      final jsonData = json.decode(response.body);
      userData = jsonData.map<UsersData>((jsonData)=>UsersData.fromJson(jsonData)).toList();
      return userData;
    }else{
      print("Mandar Error in URL");
    }
  }
}