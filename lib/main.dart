import "package:flutter/material.dart";
import './app_screens/login.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Rasthiyaduwa",
        home: Scaffold(
            body: Login()
        ),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          accentColor: Colors.white,
        ),
    );
    throw UnimplementedError();
  }
}
