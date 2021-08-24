import 'package:cloud_firestore/cloud_firestore.dart';

class Alerte {
  String id;
  String de;
  double latitude;
  double longitude;
  Timestamp timestamp;
  bool vue;

  Alerte({this.id, this.de, this.latitude, this.longitude, this.timestamp, this.vue});
}