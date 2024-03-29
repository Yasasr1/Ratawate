import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'dart:async';
import 'dart:math';
import 'package:multi_image_picker/multi_image_picker.dart';
import 'dart:typed_data';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:provider/provider.dart';
import './side_drawer.dart';
import '../providers/auth.dart';

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
  TextEditingController descriptionController = TextEditingController();
  List<Asset> images = List<Asset>();
  String _error;
  List<String> imageUrls = [];
  var _isLoading = false;

  AddDestinationState();

  void _showDialog(String message, String title) {
    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text(title),
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

  //render selected images as a grid
  Widget buildGridView() {
    if (images.length > 0)
      return GridView.count(
        crossAxisCount: 3,
        children: List.generate(images.length, (index) {
          Asset asset = images[index];
          return AssetThumb(
            asset: asset,
            width: 300,
            height: 300,
          );
        }),
      );
    else
      return Container(
        width: double.infinity,
        color: Colors.grey[300],
        child: Center(child: Text("No images selected...")),
      );
  }

  //select and load images
  Future<void> loadAssets() async {
    setState(() {
      images = List<Asset>();
    });

    List<Asset> resultList;
    String error;

    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
      );
    } on Exception catch (e) {
      error = e.toString();
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      images = resultList;
      if (error == null) _error = 'No Error Dectected';
    });
  }

  //random string generator for image names
  String _randomString(int length) {
    var rand = new Random();
    var codeUnits = new List.generate(length, (index) {
      return rand.nextInt(33) + 89;
    });

    return new String.fromCharCodes(codeUnits);
  }

  //handle uploading a single image
  Future uploadImage(Asset asset) async {
    //get image data compressed
    ByteData byteData = await asset.getByteData(quality: 30);
    String randString = _randomString(50);
    print(randString);
    List<int> imageData = byteData.buffer.asUint8List();
    StorageReference ref = FirebaseStorage.instance
        .ref()
        .child('/destinationImages')
        .child(randString);
    StorageUploadTask uploadTask = ref.putData(imageData);

    return await (await uploadTask.onComplete).ref.getDownloadURL();
  }

  Future submitDestination() async {
    setState(() {
      _isLoading = true;
    });
    List<String> urls = [];
    try {
      //upload all images
      for (int i = 0; i < images.length; i++) {
        String url = await uploadImage(images[i]);
        urls.add(url);
      }
      setState(() {
        imageUrls = urls;
      });

      var uid = Provider.of<Auth>(context, listen: false).getUserId();

      var responce = await Firestore.instance.collection('destinations').add({
        'title': titleController.text,
        'description': descriptionController.text,
        'imageUrls': imageUrls,
        'likedUsers': [],
        'city': cityController.text,
        'district': district,
        'destinationType': type,
        'isVerified': false,
        'userId': uid,
        'latitude': 0.0,
        'longitude': 0.0
      });
      print(districtController.text);
    } catch (err) {
      _showDialog(err.toString(), 'An Error Occured!');
    }
    setState(() {
      _isLoading = false;
    });
    _showDialog(
        "Please note that image will only be displyed after verification",
        "Destination Added Succesfully");
  }

  void showSnackBar(BuildContext context) async {
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
            submitDestination().then((_) => {_reset()});
          }),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  /*void setLocation(double latitude, double longitude) {
    setState(() {
      lat = latitude;
      long = longitude;
      isLocationPicked = true;
    });
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add a new destination',
          style: TextStyle(color: Colors.white),
        ),
      ),
      drawer: SideDrawer(),
      body: Builder(
        builder: (context) => Form(
          key: _formKey,
          child: _isLoading == true
              ? Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.purple,
                  ),
                )
              : Padding(
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
                          validator: (value) =>
                              value == null ? 'Please select a type' : null,
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
                          validator: (value) =>
                              value == null ? 'Please select a district' : null,
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
                          onChanged: (value) {
                            debugPrint('Something changed in Text Field');
                          },
                          decoration: InputDecoration(
                            labelText: 'Title',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 0),
                              // add padding to adjust icon
                              child: Icon(
                                Icons.title,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
                            } else if (this.images.length == 0) {
                              return 'Please select at least 1 image';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            debugPrint('Something changed in Text Field');
                          },
                          decoration: InputDecoration(
                            labelText: 'City',
                            prefixIcon: Padding(
                              padding: EdgeInsets.only(top: 0),
                              // add padding to adjust icon
                              child: Icon(
                                Icons.location_city,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),

                      Container(
                        width: double.infinity,
                        height: 80,
                        child: buildGridView(),
                      ),

                      //Image Field
                      Padding(
                        padding: EdgeInsets.only(top: 15.0, bottom: 2.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: RaisedButton(
                                color: Theme.of(context).accentColor,
                                textColor: Colors.black54,
                                child: Text(
                                  'Add Images',
                                  textScaleFactor: 1.5,
                                ),
                                onPressed: loadAssets,
                              ),
                            ),
                          ],
                        ),
                      ),

                      //Description Field
                      Padding(
                        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                        child: TextFormField(
                          maxLines: 10,
                          minLines: 4,
                          controller: descriptionController,
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a Description';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            debugPrint('Something changed in Text Field');
                          },
                          decoration: InputDecoration(
                            labelText: 'Description',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
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
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
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

  void _reset() {
    titleController.text = '';
    type = '';
    district = '';
    cityController.text = '';
    descriptionController.text = '';
    images = [];
  }
}
