import 'package:flutter/widgets.dart';

class Destination with ChangeNotifier {
  String id;
  String title;
  String description;
  List<dynamic> imageUrls;
  List<dynamic> likedUsers;
  double latitude;
  double longitude;
  String city;
  String district;
  String destinationType;
  bool isVerified;

  Destination(
      {this.id,
      this.title,
      this.description,
      this.imageUrls,
      this.likedUsers,
      this.latitude,
      this.longitude,
      this.city,
      this.district,
      this.destinationType,
      this.isVerified
      });
}

