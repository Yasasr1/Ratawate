import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class DestinationItem extends StatelessWidget {
  final bool _verified;
  final String _id;
  final String _title;
  final String _image;
  final String _district;
  final int _likes;

  DestinationItem(this._verified, this._id, this._title, this._image,
      this._district, this._likes);

  navigateToDetailsScreen(BuildContext context) {
    Navigator.of(context).pushNamed('/destinationDetails', arguments: _id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3)),
      ], color: Colors.white),
      height: 370,
      margin: EdgeInsets.only(bottom: 15),
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              !_verified
                  ? Container(
                      decoration: BoxDecoration(color: Colors.grey),
                      height: 320,
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
                    )
                  : CachedNetworkImage(
                      height: 320,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      imageUrl: _image,
                      placeholder: (context, url) => Container(
                        height: 320,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.grey),
                        child: CircularProgressIndicator(),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 320,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(color: Colors.grey),
                        child: Text("Failed to load image..."),
                      ),
                    ),
              Container(
                child: Text(
                  _title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                padding:
                    EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 30),
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.black87, Colors.transparent],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter)),
              ),
              Positioned.fill(
                  child: Material(
                child: InkWell(
                  splashColor: Colors.purple.withOpacity(0.2),
                  onTap: () => navigateToDetailsScreen(context),
                ),
                color: Colors.transparent,
              ))
            ],
          ),
          Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(Icons.location_on),
                    Text(
                      _district,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Icon(Icons.thumb_up),
                    SizedBox(
                      width: 5,
                    ),
                    Text(_likes.toString()),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
