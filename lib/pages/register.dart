import 'package:auth_app/restapi/controller_api.dart';
import 'package:flutter/material.dart';
import 'package:auth_app/pages/login.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  ControllerAPI controllerAPI = new ControllerAPI();
  

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  onPress() {
    setState(() {
      if(
        nameController.text.trim().toLowerCase().isNotEmpty &&
        emailController.text.trim().toLowerCase().isNotEmpty &&
        passwordController.text.trim().isNotEmpty){
          controllerAPI.register(
            nameController.text.trim(),
            emailController.text.trim(),
            passwordController.text.trim()
          ).whenComplete((){
            if(controllerAPI.status == true){
              showMessage();
            }else{
              Navigator.pushReplacementNamed(context, "/");
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
            content: new Text('Your email already exists!'),
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
          title: Text('Register'),
          leading: new IconButton(
            icon: new Icon(Icons.keyboard_backspace),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                  child: Center(
                    child: Container(
                      child: Text(
                        "Register Simple API",
                        style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.indigo[700]),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
                  child: Container(
                    child: new TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        hintText: 'Enter your name',
                        icon: new Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
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
                        'Register',
                        style: new TextStyle(
                            color: Colors.white, backgroundColor: Colors.blue),
                      ),
                    ),
                  ),
                ),
                
                Container(
                  height: 50,
                  child: new FlatButton(
                    onPressed: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => new Login(),
                    )),
                    
                    child: new Text(
                      'Login',
                      style: new TextStyle(
                        color: Colors.blue,
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
