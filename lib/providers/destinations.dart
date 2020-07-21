import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../providers/destination.dart';

class Destinations with ChangeNotifier {
  List<Destination> _destinations = [];
  Destinations();

  Future<void> fetchDestinations() async {
    /*final url = "https://ratawate-6221a.firebaseio.com/destinations.json?auth=$authToken";
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
    }*/
    try {
      final List<Destination> loadedDestinations = [];
      /*final responce =
          await Firestore.instance.collection("destinations").getDocuments();
      responce.documents.forEach((document) {
        loadedDestinations.add(Destination(
          id: document.documentID,
          title: document['title'],
          description: document['description'],
          city: document['city'],
          district: document['district'],
          destinationType: document['destinationType'],
          imageUrls: document['imageUrls'],
          latitude: document['latitude'],
          longitude: document['longitude'],
          likedUsers: document['likedUsers'],
        ));
      });*/
      Firestore.instance.collection("destinations").snapshots().listen((data) {
        data.documents.forEach((document) {
          loadedDestinations.add(Destination(
            id: document.documentID,
            title: document['title'],
            description: document['description'],
            city: document['city'],
            district: document['district'],
            destinationType: document['destinationType'],
            imageUrls: document['imageUrls'],
            latitude: document['latitude'],
            longitude: document['longitude'],
            likedUsers: document['likedUsers'],
            isVerified: document['isVerified']
          ));
        });
      });
      _destinations = loadedDestinations;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  List<Destination> get getDestinations {
    return [..._destinations];
  }

  Destination getById(String id) {
    final destinationList = [..._destinations];
    Destination destinationFound = destinationList.firstWhere((des) {
      return des.id == id;
    });
    return destinationFound;
  }
}
