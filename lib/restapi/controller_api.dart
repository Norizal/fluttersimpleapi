import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:auth_app/restapi/model_api.dart';

import 'model_api.dart';
import 'model_api.dart';

class ControllerAPI {
  
  String serverUrl = "https://simpleapi.rizal23.com/api";
  var status ;
  var token ;


  login(String email, String password) async {
     String loginUrl = "$serverUrl/login";

    final response = await http.post(
      loginUrl,
      headers: {
        'Accept': 'application/json'
      },
      body: {
        "email": "$email",
        "password": "$password"
      });

       var data = json.decode(response.body);

      status = data["error"];

      if(status == true){
        print("Error pada login");
      }else{
        print("Login OK");
        savePreferences(data["token"]);
      }



  }

  register(String name, String email, String password) async {
    String registerUrl = "$serverUrl/register";

    final response = await http.post(
      registerUrl,
      headers: {
        'Accept': 'application/json'
      },
      body: {
        "name": "$name",
        "email": "$email",
        "password": "$password"
      });

      var data = json.decode(response.body);

      status = data["error"];

      if(status == true){
        print("Error pada registration");
      }else{
        print("Registration OK");
      }

  }


  savePreferences(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    sharedPreferences.setString(key, value);



  }


  readPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    print("read: $value");
  }



  Future<List<ItemModel>> getItem() async {

    final sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;

    String getItemUrl = "$serverUrl/getItem";

    http.Response response = await http.get(
      getItemUrl,
      headers : {
        'Accept': 'application/json',
        'Authorization': 'Bearer $value'
      });

      if(response.statusCode == 200){
        print("Item berjaya get");

        return parseItems(response.body);

      }else{
        print("Error pada Item get");

      }

    

    
  }


  List<ItemModel> parseItems(String responseBody){
    final parseItem = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parseItem.map<ItemModel>((json) => ItemModel.fromMap(json)).toList();


  }




  
}