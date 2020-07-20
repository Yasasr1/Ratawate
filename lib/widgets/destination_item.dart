import 'package:flutter/material.dart';

class DestinationItem extends StatelessWidget {
  final String _title;
  final String _image;
  final String _district;
  final int _likes;

  DestinationItem(this._title, this._image, this._district, this._likes);
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
              Image.network(
                _image,
                height: 320,
                width: double.infinity,
                fit: BoxFit.cover,
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
                  onTap: () {},
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
