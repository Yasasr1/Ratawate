import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:rasthiyaduwa_app/app_screens/add_destination.dart';
import 'package:rasthiyaduwa_app/app_screens/home_screen.dart';
import '../app_screens/login.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';


class SideDrawer extends StatefulWidget {
  @override
  SideDrawerState createState() => SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {


  void logout() {
    FirebaseAuth.instance.signOut();
     Provider.of<Auth>(context, listen: false).deleteUserId();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  "piyumal@gmail.com",
                  style: TextStyle(
                    fontSize: 20,
                    color: Theme.of(context).accentColor,
                  ),
                )
              ],
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text(
              'Destinations',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => HomeScreen())
              );
            },
          ),
          ListTile(
            title: Text(
              'Add Destinations',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (BuildContext context) => AddDestination())
              );
            },
          ),
          ListTile(
            title: Text(
              'Change my password',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              //Change password
            },
          ),
          ListTile(
            title: Text(
              'Log out',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: logout,
          ),
        ],
      ),
    );
  }
}
