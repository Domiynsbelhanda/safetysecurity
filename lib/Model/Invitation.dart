import 'package:cloud_firestore/cloud_firestore.dart';

class Invitation {
  String expeditaire;
  String destinataire;
  Timestamp timestamp;
  bool vu;
  bool accepte;
  bool refuse;

  Invitation({this.expeditaire, this.destinataire, this.timestamp, this.vu, this.accepte, this.refuse});
}