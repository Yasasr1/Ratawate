import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../providers/auth.dart';
import '../widgets/display_location.dart';
import '../providers/destinations.dart';
import '../providers/destination.dart';

class DestinationDetailsScreen extends StatefulWidget {
  @override
  _DestinationDetailsScreenState createState() =>
      _DestinationDetailsScreenState();
}

class _DestinationDetailsScreenState extends State<DestinationDetailsScreen> {
  Destination fetchedDestination;
  String uid;
  var isLiked = false;
  bool isLoading = true;
  String id;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      id = ModalRoute.of(context).settings.arguments;
      fetchedDestination = Provider.of<Destinations>(context).getById(id);
      uid = Provider.of<Auth>(context, listen: false).getUserId();
      fetchedDestination.likedUsers.forEach((element) {
        if (element == uid) {
          setState(() {
            isLiked = true;
          });
        }
      });
      //print(fetchedDestination['title']);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
  }

  void likeOrUnlike() async {
    if (isLiked == true) {
      fetchedDestination.likedUsers.remove(uid);
      setState(() {
        isLiked = false;
      });
    } else {
      fetchedDestination.likedUsers.add(uid);
      setState(() {
        isLiked = true;
      });
    }

    try {
      var responce = await Firestore.instance
          .collection('destinations')
          .document(id)
          .updateData({'likedUsers': fetchedDestination.likedUsers});
      Provider.of<Destinations>(context).fetchDestinations();
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: isLoading
            ? Text("loading..")
            : Text(
                fetchedDestination.title,
                style: TextStyle(color: Colors.purple),
              ),
        iconTheme: new IconThemeData(color: Colors.purple),
      ),
      body: isLoading
          ? Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.purple,
              ),
            )
          : Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      child: CarouselSlider(
                        options: CarouselOptions(height: 300.0),
                        items: fetchedDestination.imageUrls.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration: BoxDecoration(color: Colors.grey),
                                  child: fetchedDestination.isVerified
                                      ? CachedNetworkImage(
                                          height: 320,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                          imageUrl: image,
                                          placeholder: (context, url) =>
                                              Container(
                                            height: 320,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey),
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Container(
                                            height: 320,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.grey),
                                            child:
                                                Text("Failed to load image..."),
                                          ),
                                        )
                                      : Container(
                                          child: Center(
                                            child: Text(
                                              "Unverified Destination. Images will be displayed after verification",
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontStyle: FontStyle.italic,
                                              ),
                                            ),
                                          ),
                                        ));
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: Column(
                        children: <Widget>[
                          !fetchedDestination.isVerified
                              ? Icon(Icons.warning)
                              : Icon(Icons.done, color: Colors.green),
                          !fetchedDestination.isVerified
                              ? Text(
                                  "This destination is not yet verified. And may be deleted if it dosen't adhere to our guidlines")
                              : Text("Verified Destination"),
                        ],
                      ),
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: fetchedDestination.isVerified
                              ? Colors.green[100]
                              : Colors.purple[200],
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.terrain),
                          Text(fetchedDestination.destinationType),
                          Icon(Icons.place),
                          Text(fetchedDestination.district),
                          Icon(Icons.business),
                          Text(fetchedDestination.city),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          fetchedDestination.likedUsers.length == 1
                              ? Text(
                                  fetchedDestination.likedUsers.length
                                          .toString() +
                                      " Like",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                )
                              : Text(
                                  fetchedDestination.likedUsers.length
                                          .toString() +
                                      " Likes",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                          SizedBox(
                            width: 20,
                          ),
                          IconButton(
                            onPressed: likeOrUnlike,
                            icon: Icon(
                              Icons.thumb_up,
                              color: isLiked ? Colors.purple : Colors.black,
                              size: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        fetchedDestination.description,
                      ),
                    ),
                    (fetchedDestination.latitude != 0.0 &&
                            fetchedDestination.longitude != 0.0)
                        ? Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Center(
                                    heightFactor: 2,
                                    child: Text(
                                      "Location",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  FlatButton.icon(
                                      onPressed: () {
                                        MapsLauncher.launchCoordinates(
                                            fetchedDestination.latitude, fetchedDestination.longitude);
                                      },
                                      icon: Icon(Icons.map, color: Colors.purple,),
                                      label: Text("Open in maps"))
                                ],
                              ),
                              Container(
                                height: 300,
                                child: DisplayLocation(
                                    fetchedDestination.latitude,
                                    fetchedDestination.longitude),
                              ),
                            ],
                          )
                        : Center(
                            child: Text("Location not verified"),
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
