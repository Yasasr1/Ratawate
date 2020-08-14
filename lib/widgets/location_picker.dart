import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/services.dart';
import 'package:latlong/latlong.dart';
import 'package:location/location.dart';

class LocationPicker extends StatefulWidget {
  final Function setLocation;
  LocationPicker(this.setLocation);
  @override
  _LocationPickerState createState() => _LocationPickerState();
}

class _LocationPickerState extends State<LocationPicker> {
  Marker marker;
  LocationData currLocation;
  

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    marker = Marker(
      width: 20.0,
      height: 20.0,
      point: new LatLng(6.894116, 79.867630),
      builder: (ctx) => Container(
        child: Icon(Icons.gps_fixed),
      ),
    );
    initLocationService();
  }

  void initLocationService() async {
    final Location _locationService = Location();
    await _locationService.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );

    LocationData location;
    bool serviceEnabled;
    bool _permission = false;
    bool serviceRequestResult;

    try {
      serviceEnabled = await _locationService.serviceEnabled();

      if (serviceEnabled) {
        var permission = await _locationService.requestPermission();
        _permission = permission == PermissionStatus.granted;

        if (_permission) {
          location = await _locationService.getLocation();
          setState(() {
            marker = Marker(
              width: 20.0,
              height: 20.0,
              point: new LatLng(location.latitude, location.longitude),
              builder: (ctx) => Container(
                child: Icon(Icons.gps_fixed),
              ),
            );
            currLocation = location;
          });
        }
      } else {
        serviceRequestResult = await _locationService.requestService();
        if (serviceRequestResult) {
          initLocationService();
          return;
        }
      }
    } on PlatformException catch (e) {
      print(e);
      if (e.code == 'PERMISSION_DENIED') {
        print("permission denied");
      } else if (e.code == 'SERVICE_STATUS_ERROR') {
        print("service error");
      }
      location = null;
    }
  }

  void _handleTap(LatLng latlng) {
    var m = Marker(
      width: 40.0,
      height: 40.0,
      point: latlng,
      builder: (ctx) => Container(
        child: Icon(Icons.location_on),
      ),
    );
    setState(() {
      marker = m;
    });
    //print(latlng);
    widget.setLocation(latlng.latitude, latlng.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: FlutterMap(
      options: MapOptions(
          center: LatLng(currLocation != null ? currLocation.latitude : 6.893385 ,currLocation != null ? currLocation.longitude : 79.858983), zoom: 7.0, onTap: _handleTap),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayerOptions(
          markers: [marker],
        ),
      ],
    ));
  }
}
