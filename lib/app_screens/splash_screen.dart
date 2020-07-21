import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Center(
            child: Text("Ratawate Logo",style: TextStyle(fontSize: 24),),
          ),
          Center(
            child: Text("Loading..."),
          ),
        ],
      ),
    );
  }
}
