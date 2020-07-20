import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/destination.dart';

class Destinations with ChangeNotifier {
  List<Destination> _destinations = [];
  final String authToken;
  Destinations(this.authToken, this._destinations);

  Future<void> fetchDestinations() async {
    final url = "https://ratawate-6221a.firebaseio.com/destinations.json?auth=$authToken";
    try {
      final responce = await http.get(url);
      final List<Destination> loadedDestinations = [];
      final extractedData = json.decode(responce.body) as Map<String, dynamic>;
      extractedData.forEach((desId, des) {
        loadedDestinations.add(Destination(
          id: desId,
          title: des['title'],
          description: des['description'],
          city: des['city'],
          imageUrls: des['imageUrls'],
          latitude: des['latitude'],
          longitude: des['longitude'],
          likedUsers: des['likedUsers'],
        ));
       });
       _destinations = loadedDestinations;
       notifyListeners();

    } catch (error) {
      throw (error);
    }
  }

  List<Destination> get getDestinations {
    return [..._destinations];
  }
}