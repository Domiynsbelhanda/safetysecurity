import 'package:cloud_firestore/cloud_firestore.dart';

class Articles {
  String titre;
  String description;
  String id;
  String date;
  String image;
  Timestamp timestamp;
  int like;
  int comment;
  String uid;

  Articles({
    this.titre,
    this.description,
    this.id,
    this.date,
    this.image,
    this.timestamp,
    this.like,
    this.comment,
    this.uid
  });
}