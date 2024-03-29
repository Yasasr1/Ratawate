import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../app_screens/add_destination.dart';
import '../app_screens/home_screen.dart';
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
    Navigator.of(context)
        .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
  }

  @override
  Widget build(BuildContext context) {
    final email = Provider.of<Auth>(context).getEmail();
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
                  email,
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
            leading: Icon(
              Icons.location_searching,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Destinations',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => HomeScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.plus_one,
              color: Theme.of(context).primaryColor,
            ),
            title: Text(
              'Add Destinations',
              style: TextStyle(
                fontSize: 20,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onTap: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) => AddDestination()));
            },
          ),
          /*ListTile(
            leading: Icon(Icons.lock_open, color: Theme.of(context).primaryColor,),
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
          ),*/
          ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Theme.of(context).primaryColor,
            ),
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
