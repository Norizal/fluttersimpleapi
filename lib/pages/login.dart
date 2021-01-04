import 'package:auth_app/restapi/controller_api.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/pages/register.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:auth_app/pages/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  readPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    final key = 'token';
    final value = sharedPreferences.get(key) ?? 0;
    if(value != '0'){
      Navigator.of(context).push(new MaterialPageRoute(
        builder: (BuildContext context) => new Home(),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    readPreferences();
  }

  ControllerAPI controllerAPI = new ControllerAPI();
 

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  onPress() {
    setState(() {
      if (emailController.text.trim().toLowerCase().isNotEmpty &&
          passwordController.text.trim().isNotEmpty) {
        controllerAPI
            .login(emailController.text.trim().toLowerCase(),
                passwordController.text.trim())
            .whenComplete(() {
          if (controllerAPI.status == true) {
            showMessage();
          } else {
            Navigator.pushReplacementNamed(context, '/home');
          }
        });
      }
    });
  }

  showMessage() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text('Failed'),
            content: new Text('Check your email or password'),
            actions: <Widget>[
              new RaisedButton(
                child: new Text(
                  'Close',
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                  child: Center(
                    child: Container(
                        child: new Text("Login Simple API",
                            style: TextStyle(
                                color: Colors.indigo[700],
                                fontSize: 30,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                  child: Container(
                    child: new TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        hintText: 'Enter your email',
                        icon: new Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Container(
                    child: new TextField(
                      controller: passwordController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        icon: new Icon(Icons.vpn_key),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 0.0),
                  child: Container(
                    height: 50,
                    child: new RaisedButton(
                      onPressed: onPress,
                      color: Colors.blue,
                      child: new Text(
                        'Login',
                        style: new TextStyle(
                            color: Colors.white, backgroundColor: Colors.blue),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
                  child: Container(
                    child: FlatButton(
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                        builder: (BuildContext context) => new Register(),
                      )),
                      child: new Text(
                        'Register Now!',
                        style: new TextStyle(
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
