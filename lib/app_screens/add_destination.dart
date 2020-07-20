import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';

class AddDestination extends StatefulWidget {
  @override
  AddDestinationState createState() => AddDestinationState();
}

class AddDestinationState extends State<AddDestination> {
  String type;
  String district;
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    type = '';
    district = '';
  }

  TextEditingController titleController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController imageUrlsController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  AddDestinationState();

  void send() async {
    debugPrint('funtion called');
    var body = jsonEncode({
      'title': titleController.text,
      'type': typeController.text,
      'district': districtController.text,
      'city': cityController.text,
      'location': locationController.text,
      'imageUrls': imageUrlsController.text,
      'description': descriptionController.text,
    });
    //send json
  }

  void showSnackBar(BuildContext context) {
    var snackBar = SnackBar(
      backgroundColor: Colors.black54,
      content: Text(
        'Are you sure?',
        style: TextStyle(fontSize: 20, color: Colors.white70),
      ),
      action: SnackBarAction(
          textColor: Colors.cyan,
          label: "YES",
          onPressed: () {
            //add destination
            _reset();
          }),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a new destination'),
      ),
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
            child: ListView(
              children: <Widget>[
                //Type Field
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: DropDownFormField(
                    titleText: 'Type',
                    hintText: 'Please choose one',
                    value: type,
                    onSaved: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        type = value;
                      });
                    },
                    dataSource: [
                      {
                        "display": "Beach",
                        "value": "Beach",
                      },
                      {
                        "display": "Hiking",
                        "value": "Hiking",
                      },
                      {
                        "display": "Historical",
                        "value": "Historical",
                      },
                      {
                        "display": "Nature",
                        "value": "Nature",
                      },
                      {
                        "display": "Park",
                        "value": "Park",
                      },
                      {
                        "display": "Religious",
                        "value": "Religious",
                      },
                      {
                        "display": "Water",
                        "value": "Water",
                      },
                      {
                        "display": "Waterfall",
                        "value": "Waterfall",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),

                //District Field
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: DropDownFormField(
                    titleText: 'District',
                    hintText: 'Please choose one',
                    value: district,
                    onSaved: (value) {
                      setState(() {
                        district = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        district = value;
                      });
                    },
                    dataSource: [
                      {
                        "display": "Ampara",
                        "value": "Ampara",
                      },
                      {
                        "display": "Anuradhapura",
                        "value": "Anuradhapura",
                      },
                      {
                        "display": "Badulla",
                        "value": "Badulla",
                      },
                      {
                        "display": "Batticaloa",
                        "value": "Batticaloa",
                      },
                      {
                        "display": "Colombo",
                        "value": "Colombo",
                      },
                      {
                        "display": "Galle",
                        "value": "Galle",
                      },
                      {
                        "display": "Gampaha",
                        "value": "Gampaha",
                      },
                      {
                        "display": "Hambantota",
                        "value": "Hambantota",
                      },
                      {
                        "display": "Jaffna",
                        "value": "Jaffna",
                      },
                      {
                        "display": "Kalutara",
                        "value": "Kalutara",
                      },
                      {
                        "display": "Kandy",
                        "value": "Kandy",
                      },
                      {
                        "display": "Kegalle",
                        "value": "Kegalle",
                      },
                      {
                        "display": "Kilinochchi",
                        "value": "Kilinochchi",
                      },
                      {
                        "display": "Kurunegala",
                        "value": "Kurunegala",
                      },
                      {
                        "display": "Mannar",
                        "value": "Mannar",
                      },
                      {
                        "display": "Matale",
                        "value": "Matale",
                      },
                      {
                        "display": "Matara",
                        "value": "Matara",
                      },
                      {
                        "display": "Monaragala",
                        "value": "Monaragala",
                      },
                      {
                        "display": "Mullaitivu",
                        "value": "Mullaitivu",
                      },
                      {
                        "display": "NuwaraEliya",
                        "value": "NuwaraEliya",
                      },
                      {
                        "display": "Polonnaruwa",
                        "value": "Polonnaruwa",
                      },
                      {
                        "display": "Puttalam",
                        "value": "Puttalam",
                      },
                      {
                        "display": "Ratnapura",
                        "value": "Ratnapura",
                      },
                      {
                        "display": "Trincomalee",
                        "value": "Trincomalee",
                      },
                      {
                        "display": "Vavuniya",
                        "value": "Vavuniya",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),

                //Title Field
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: titleController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a Title';
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
                        labelText: 'Title',
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

                //City Field
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: cityController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a City';
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
                        labelText: 'City',
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

                //Location Field
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: locationController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a Location';
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
                        labelText: 'Location',
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

                //Image Field
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    controller: imageUrlsController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a Title';
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
                        labelText: 'imageUrls',
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

                //Description Field
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: TextFormField(
                    maxLines: null,
                    controller: descriptionController,
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter the description';
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
                        labelText: 'Description',
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(top: 0),
                          // add padding to adjust icon
                          child: Icon(
                            Icons.description,
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

                //Buttons
                Padding(
                  padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Row(
                    children: <Widget>[
                      //Reset Button
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColor,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      ),

                      //Add Button
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Theme.of(context).accentColor,
                          child: Text(
                            'Add',
                            textScaleFactor: 1.5,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_formKey.currentState.validate()) {
                                showSnackBar(context);
                                debugPrint('Add button clicked');
                              }
                            });
                          },
                        ),
                      ),
                    ],
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

  void _reset() {
    titleController.text = '';
    typeController.text = '';
    districtController.text = '';
    cityController.text = '';
    locationController.text = '';
    imageUrlsController.text = '';
    descriptionController.text = '';
  }
}
