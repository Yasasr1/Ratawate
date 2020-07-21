import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/destination.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_icons/flutter_icons.dart';

import '../providers/destinations.dart';

class DestinationDetailsScreen extends StatefulWidget {
  @override
  _DestinationDetailsScreenState createState() =>
      _DestinationDetailsScreenState();
}

class _DestinationDetailsScreenState extends State<DestinationDetailsScreen> {
  Destination fetchedDestination;
  bool isLoading = true;
  String id;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      id = ModalRoute.of(context).settings.arguments;
      fetchedDestination = Provider.of<Destinations>(context).getById(id);
      //print(fetchedDestination['title']);
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
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
                                  child: Image.network(
                                    image['url'],
                                    fit: BoxFit.cover,
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
                            Icon(Icons.warning),
                            Text(
                                "This location is not yet verified. And may be deleted if it dosen't adhere to our guidlines"),
                          ],
                        ),
                      
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(color: Colors.purple[200], borderRadius: BorderRadius.circular(10)),
                    ),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Icon(Icons.terrain),
                          Text("WaterFall"),
                          Icon(Icons.place),
                          Text("District"),
                          Icon(Icons.business),
                          Text(fetchedDestination.city),
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            fetchedDestination.likedUsers.length.toString(),
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.thumb_up,
                            color: Colors.black,
                            size: 30,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Text(
                        fetchedDestination.description,
                      ),
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
