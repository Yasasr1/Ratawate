import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

import '../providers/destination.dart';

class Destinations with ChangeNotifier {
  List<Destination> _destinations = [];
  String _district = 'All';
  String _destinationType = 'All';
  String _searchTerm = '';
  Destinations();

  Future<void> fetchDestinations() async {
    //Get destinations using realtime database - not used anymore
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
      final responce =
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
            isVerified: document['isVerified']));
      });
      //If listening to realtime updates on firestore - currently only getting data once
      /*Firestore.instance.collection("destinations").snapshots().listen((data) {
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
      });*/
      _destinations = loadedDestinations;
      notifyListeners();
    } catch (err) {
      print(err);
    }
  }

  void setFilters(String dType, String dis) {
    _district = dis;
    _destinationType = dType;
    notifyListeners();
  }

  void setSearchTerm(String sTerm) {
    _searchTerm = sTerm;
    notifyListeners();
  }

  String getType() {
    return _destinationType;
  }

  String getDistrict() {
    return _district;
  }

  //return the destinations - considering filters and search terms
  List<Destination> get getDestinations {
    var allDestinations = [..._destinations];
    List<Destination> searchResults;
    List<Destination> filteredByDistrict;
    List<Destination> filteredByType;
    if (_district.compareTo('All') != 0) {
      filteredByDistrict = allDestinations
          .where((destination) => destination.district == _district)
          .toList();
      allDestinations = filteredByDistrict;
    }
    if (_destinationType.compareTo('All') != 0) {
      filteredByType = allDestinations
          .where(
              (destination) => destination.destinationType == _destinationType)
          .toList();
      allDestinations = filteredByType;
    }
    if (_searchTerm != null) {
      if (_searchTerm.length != 0) {
        searchResults = allDestinations
            .where((element) =>
                element.title.toLowerCase().contains(_searchTerm.toLowerCase()))
            .toList();
        return searchResults;
      }
    }
    return allDestinations;
  }

  Destination getById(String id) {
    final destinationList = [..._destinations];
    Destination destinationFound = destinationList.firstWhere((des) {
      return des.id == id;
    });
    return destinationFound;
  }
}
