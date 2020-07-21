import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../providers/auth.dart';
import '../models/http_exception.dart';

class Login extends StatefulWidget {
  @override
  LoginState createState() => LoginState();
}

class LoginState extends State<Login> {
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

  LoginState();

  Future<void> login() async {
    final _auth = FirebaseAuth.instance;
    AuthResult authResult;
    setState(() {
      isLoading = true;
    });
    try {
    authResult = await _auth.signInWithEmailAndPassword(email: usernameController.text, password: passwordController.text);
    Provider.of<Auth>(context, listen: false).setUserId(authResult.user.uid);
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
    AssetImage assetImage = AssetImage('images/logo.png');
    Image image = Image(
      image: assetImage,
      width: 250.0,
      height: 250.0,
    );
    var _mediaQueryData = MediaQuery.of(context);
    var screenWidth = _mediaQueryData.size.width;
    TextStyle defaultStyle = TextStyle(color: Colors.grey, fontSize: 20.0);
    TextStyle linkStyle = TextStyle(color: Theme.of(context).primaryColor);
    return Scaffold(
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                //Logo ekata
                Container(height: 50),
                Center(
                  child: Container(
                    child: image,
                  ),
                ),

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
                        labelText: 'Email',
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

                //Login button
                if (isLoading)
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.purple,
                    ),
                  )
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
                        'Login',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            login();
                          }
                        });
                      },
                    ),
                  ),

                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.1, vertical: 8.0),
                  child: RichText(
                    text: TextSpan(
                      style: defaultStyle,
                      children: <TextSpan>[
                        TextSpan(text: "Dont't have an account? "),
                        TextSpan(
                            text: 'Register',
                            style: linkStyle,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).pushNamed(
                                  '/register',
                                );
                              }),
                      ],
                    ),
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
