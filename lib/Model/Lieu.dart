import 'package:cloud_firestore/cloud_firestore.dart';

class Lieu {
  String id;
  String denomination;
  String description;
  String adresse;
  double latitude;
  double longitude;
  String placeId;
  Timestamp timestamp;

  Lieu({
    this.id,
    this.denomination,
    this.description,
    this.adresse,
    this.latitude,
    this.longitude,
    this.placeId,
    this.timestamp
  });
}