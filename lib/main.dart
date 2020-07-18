import "package:flutter/material.dart";
import 'package:rasthiyaduwa_app/app_screens/register.dart';
import './app_screens/login.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './app_screens/home_screen.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        )
      ],
      child: Consumer<Auth>(builder: (ctx, auth, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Rasthiyaduwa",
        home: auth.isAuth ? HomeScreen() : Login(),
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: Colors.purple,
          accentColor: Colors.white,
        ),
        routes: {
          '/register': (context) => Register(),
        },
      ),)
    );
  }
}
