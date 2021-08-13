import 'package:cloud_firestore/cloud_firestore.dart';

class Commentaires {
  String id;
  String description;
  Timestamp timestamp;

  Commentaires({this.id, this.description, this.timestamp});
}