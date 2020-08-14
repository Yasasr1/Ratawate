import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

class DisplayLocation extends StatelessWidget {
  double lat;
  double lon;
  DisplayLocation(this.lat,this.lon);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: FlutterMap(
        options: new MapOptions(
          center: new LatLng(lat, lon),
          zoom: 10.0,
        ),
        layers: [
          new TileLayerOptions(
              urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
              subdomains: ['a', 'b', 'c']),
          new MarkerLayerOptions(
            markers: [
              new Marker(
                width: 20.0,
                height: 20.0,
                point: new LatLng(lat, lon),
                builder: (ctx) => new Container(
                  child: Icon(Icons.location_on),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
