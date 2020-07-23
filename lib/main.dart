import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:rasthiyaduwa_app/app_screens/destination_details_screen.dart';
import 'package:rasthiyaduwa_app/app_screens/register.dart';
import 'package:rasthiyaduwa_app/app_screens/splash_screen.dart';
import 'package:rasthiyaduwa_app/providers/destinations.dart';
import './app_screens/login.dart';
import 'package:provider/provider.dart';

import './providers/auth.dart';
import './app_screens/home_screen.dart';
import './app_screens/add_destination.dart';
import './app_screens/home_screen.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProvider.value(
           value: Destinations()),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: "RataWate",
            home: StreamBuilder(stream: FirebaseAuth.instance.onAuthStateChanged, builder:(ctx, userSnapShot) {
              if (userSnapShot.hasData) {
                return HomeScreen();
              } else {
                return Login();
              }
            } ,),
            theme: ThemeData(
              iconTheme: IconThemeData(color: Colors.purple),
              brightness: Brightness.light,
              primarySwatch: Colors.purple,
              accentColor: Colors.white,
            ),
            routes: {
              '/register': (context) => Register(),
              '/homescreen': (context) => HomeScreen(),
              '/adddestination': (context) => AddDestination(),
              '/destinationDetails': (context) => DestinationDetailsScreen(),
              '/login': (context) => Login()
            },
          ),
        ));
  }
}
