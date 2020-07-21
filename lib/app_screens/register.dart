import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';


import '../providers/auth.dart';
import '../models/http_exception.dart';

class Register extends StatefulWidget {
  @override
  RegisterState createState() => RegisterState();
}

class RegisterState extends State<Register> {
  var _formKey = GlobalKey<FormState>();

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var isLoading = false;
  void _showErrorDialog(String message) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('An Error Occured!'),
              content: Text(message),
              actions: <Widget>[
                FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
            ));
  }

  RegisterState();

  Future<void> register() async {
    final _auth = FirebaseAuth.instance;
    AuthResult authResult;

    setState(() {
      isLoading = true;
    });
     try {
    authResult = await _auth.createUserWithEmailAndPassword(email: usernameController.text, password: passwordController.text);
    } on PlatformException catch (err) {
      var message = "An error occured, Please check your credentials!";
      if(err.message != null) {
        message = err.message;
      }
      _showErrorDialog(message);

    } catch (err) {
      print(err);
    }

   
    setState(() {
      isLoading = false;
    });
   
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Theme.of(context).primaryColor);
    return Scaffold(
      appBar: AppBar(
        title: Text('Join with us'),
      ),
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                Container(height: 115),

                //Username Field
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: 8.0),
                  child: TextFormField(
                    controller: usernameController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return "Username can't be empty";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (value) {
                      debugPrint('Something changed in Text Field');
                    },
                    decoration: InputDecoration(
                        labelText: 'bb',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 0),
                          // add padding to adjust icon
                          child: Icon(
                            Icons.perm_identity,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                  ),
                ),

                //Password Field
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    controller: passwordController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'You forgot to enter the password';
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (value) {
                      debugPrint('Something changed in Text Field');
                    },
                    decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 0),
                          // add padding to adjust icon
                          child: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                  ),
                ),

                //Confirm Password Field
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: 8.0),
                  child: TextFormField(
                    obscureText: true,
                    validator: (String value) {
                      if (value != passwordController.text) {
                        return "Passwords does not match";
                      }
                      return null;
                    },
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                    onChanged: (value) {
                      debugPrint('Something changed in Text Field');
                    },
                    decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 0),
                          // add padding to adjust icon
                          child: Icon(
                            Icons.lock,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        labelStyle: TextStyle(
                          color: Theme.of(context).primaryColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2.0),
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(35.0),
                        )),
                  ),
                ),

                //Login button
                if (isLoading)
                  Center(
                      child: CircularProgressIndicator(
                    backgroundColor: Colors.purple,
                  ))
                else
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.1, vertical: 8.0),
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8.0)),
                    child: RaisedButton(
                      color: Theme.of(context).primaryColor,
                      textColor: Theme.of(context).accentColor,
                      child: Text(
                        'Register',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            register();
                          }
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );

    throw UnimplementedError();
  }
}
