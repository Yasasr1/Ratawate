import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SideDrawer extends StatefulWidget {
  @override
  SideDrawerState createState() => SideDrawerState();
}

class SideDrawerState extends State<SideDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('myemail@gmail.com'),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
          ),
          ListTile(
            title: Text('Destinations'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Add Destinations'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
