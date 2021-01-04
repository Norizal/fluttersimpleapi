import 'package:flutter/material.dart';
import 'package:auth_app/pages/home.dart';
import 'package:auth_app/pages/login.dart';
import 'package:auth_app/pages/register.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Login(),
    '/register': (context) => Register(),
    '/home': (context) => Home(),
  }
));