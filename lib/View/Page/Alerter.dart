import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:safetysecurity/Model/Lieu.dart';
import 'package:safetysecurity/View/ActivityPrincipale.dart';

import '../../globalsVariables.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class Alerter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Alerter();
  }
}

class _Alerter extends State<Alerter>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  PickResult selectedPlace;
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  List<Lieu> lieux = [];

  @override
  void initState() {
    // TODO: implement initState
    lieux.clear();
    Query collectionReference = FirebaseFirestore.instance
        .collection("Users").doc(currentFirebaseUser.uid)
        .collection('lieux')
        .orderBy('timestamp', descending: true);


    collectionReference
        .snapshots()
        .listen((data) { data.docs.forEach((doc) {

      setState(() {
        lieux.add(
            new Lieu(
              id: doc.id,
              denomination: doc.get('denomination'),
              description: doc.get("description"),
              adresse: doc.get('adresse'),
              longitude: doc.get('longitude'),
              latitude: doc.get('latitude'),
              placeId: doc.get('placeId'),
              timestamp: doc.get('timestamp'),
            )
        );
      });
    });
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [

            Divider(height: 10.0,),

            SizedBox(height: 10.0),

            item('ALERTER SUR VOTRE POSITION', FontAwesomeIcons.crosshairs, () async{

              final FirebaseFirestore _firestore = FirebaseFirestore.instance;

              amis.forEach((element) {
                var data = {
                  'de': currentFirebaseUser.uid,
                  'longitude': position.longitude,
                  'latitude': position.latitude,
                  'timestamp': FieldValue.serverTimestamp(),
                  'vue': false,
                };

                _firestore.collection('Users').doc(element.id).collection('alertes').add(data);
              });
              
              var datas = {
                  'de': currentFirebaseUser.uid,
                  'longitude': position.longitude,
                  'latitude': position.latitude,
                  'timestamp': FieldValue.serverTimestamp(),
                };

                _firestore.collection('Alertes').add(datas);

              showInSnackBar('Alerte lancée', _scaffoldKey, context);

              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return HomeScreen(index: 0,);
                                })
                            );
            }),

            SizedBox(height: 5.0),

            item('ALERTER SUR UNE POSITION', FontAwesomeIcons.mapMarkedAlt, (){

              Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacePicker(
                        apiKey: apiKey,   // Put YOUR OWN KEY here.
                        onPlacePicked: (result) {
                          setState(() {
                            selectedPlace = result;
                          });

                          final FirebaseFirestore _firestore = FirebaseFirestore.instance;

                          amis.forEach((element) {
                            var data = {
                              'de': currentFirebaseUser.uid,
                              'longitude': result.geometry.location.lng,
                              'latitude': result.geometry.location.lng,
                              'timestamp': FieldValue.serverTimestamp(),
                              'vue': false,
                            };

                            _firestore.collection('Users').doc(element.id).collection('alertes').add(data);
                          });
                          
                          var datas = {
                              'de': currentFirebaseUser.uid,
                              'longitude': position.longitude,
                              'latitude': position.latitude,
                              'timestamp': FieldValue.serverTimestamp(),
                            };

                            _firestore.collection('Alertes').add(datas);

                          showInSnackBar('Alerte lancée', _scaffoldKey, context);

                          Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return HomeScreen(index: 0,);
                                })
                            );     
                          Navigator.of(context).pop();
                        },
                        initialPosition: kInitialPosition,
                        useCurrentLocation: true,
                      ),
                    ),
                  );
            }),

            SizedBox(height: 10,),

            lieux.length == 0 ? SizedBox() :
                Text(
                  'A PARTIR DE VOS LIEUX:',
                  style: TextStyle(
                    color: const Color(0xff0040ff),
                    fontSize: width(context) / 20,
                    fontWeight: FontWeight.bold
                  ),
                ),
            SizedBox(height: 5.0),

            lieux.length == 0 ? SizedBox() :
            Container(
              height: width(context) / 4,
              width: width(context) / 1.15,
              decoration: BoxDecoration(
                color: const Color(0xff0040ff),
                borderRadius: BorderRadius.circular(10.0)
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  value: lieux[0].id,
                  items: lieux.map((e){
                    return DropdownMenuItem(
                      child: Text(
                          '${e.denomination}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      value: e.id,
                    );
                  }).toList(),
                  onChanged: (value) {

                    List<Lieu> lieu = lieux.where((element) => element.id == value).toList();

                    final FirebaseFirestore _firestore = FirebaseFirestore.instance;

                      amis.forEach((element) {
                        var data = {
                          'de': currentFirebaseUser.uid,
                          'longitude': lieu.first.longitude,
                          'latitude': lieu.first.latitude,
                          'timestamp': FieldValue.serverTimestamp(),
                          'vue': false,
                        };

                        _firestore.collection('Users').doc(element.id).collection('alertes').add(data);
                      });

                      var datas = {
                          'de': currentFirebaseUser.uid,
                          'longitude': position.longitude,
                          'latitude': position.latitude,
                          'timestamp': FieldValue.serverTimestamp(),
                        };

                        _firestore.collection('Alertes').add(datas);

                      showInSnackBar('Alerte lancée', _scaffoldKey, context);

                      Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context){
                                    return HomeScreen(index: 0,);
                                  })
                              );
                  },
                  hint:Text("SELECTIONNER UNE PLACE")
                  ),
              ),
              ),
          ],
        ),
      ),
    );
  }
}