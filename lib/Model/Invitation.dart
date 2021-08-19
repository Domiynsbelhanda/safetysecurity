import 'package:cloud_firestore/cloud_firestore.dart';

class Invitation {
  String uid;
  String expeditaire;
  String destinataire;
  Timestamp timestamp;
  bool vu;
  bool accepte;
  bool refuse;

  Invitation({this.uid, this.expeditaire, this.destinataire, this.timestamp, this.vu, this.accepte, this.refuse});
}