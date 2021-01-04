import 'package:auth_app/restapi/controller_api.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/pages/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auth_app/restapi/model_api.dart';

import '../restapi/model_api.dart';
import '../restapi/model_api.dart';
import '../restapi/model_api.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ControllerAPI controllerAPI = new ControllerAPI();

  savePreferences(String token) async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = token;
    sharedPreferences.setString(key, value);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Home'),
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  savePreferences('0');
                  Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => new Login(),
                  ));
                },
              )
            ],
          ),
          body: FutureBuilder(
            future: controllerAPI.getItem(),
            builder: (BuildContext context,
                AsyncSnapshot<List<ItemModel>> snapshot) {
              if (snapshot.hasData) {
                List<ItemModel> itemModels = snapshot.data;
                return ListView(
                  children: itemModels
                      .map((ItemModel itemModel) => ListTile(
                            title: Text(itemModel.name),
                            subtitle: Text("${itemModel.amount}"),
                          ))
                      .toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          )),
    );
  }
}
