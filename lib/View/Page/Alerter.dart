import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:safetysecurity/Model/Lieu.dart';
import 'package:safetysecurity/View/ActivityPrincipale.dart';

import '../../globalsVariables.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'Notifications.dart';
import 'UserProfil.dart';

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
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0.0,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: <Color>[
                Colors.amberAccent,
                Colors.amber
              ],
            ),
          ),
        ),
        title: Text(
          'Alert'
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return Notifications();
                  })
              );
            },
            child: IconButton(
              icon: Icon(
                  Icons.notifications,
                  color: Colors.white,
                  size: width(context) / 10
              ),
            ),
          ),

          GestureDetector(
            onTap: (){
              Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context){
                    return Alerter();
                  })
              );
            },
            child: IconButton(
              icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                  size: width(context) / 10
              ),
            ),
          ),
        ],
      ),
      key: _scaffoldKey,
      body: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                Colors.amberAccent,
                Colors.deepOrange
              ],
            ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width(context) / 1.5,
                      child: Text(
                        'Alerte pour un cas d\'insecurité',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width(context) / 15
                        ),
                      ),
                    ),

                    Container(
                      width: width(context) / 4,
                      height: width(context) / 4,
                      child: Image.asset(
                        'assets/img/logo2.png',
                        fit: BoxFit.cover,
                      ),
                    )
                  ],
                ),
              ),

              SizedBox(height: 10.0),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Veuillez Choisir une position.',
                  style: TextStyle(
                    fontSize: width(context) / 20
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: item('ALERTER SUR VOTRE POSITION', FontAwesomeIcons.crosshairs, () async{

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
                    ),
                    Expanded(
                      child: item('ALERTER SUR UNE POSITION', FontAwesomeIcons.mapMarkedAlt, (){

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
                    )
                  ],
                ),
              ),

              SizedBox(height: 5.0),


              SizedBox(height: 10,),

              lieux.length == 0 ? SizedBox() :
                  Text(
                    'A PARTIR DE VOS LIEUX:',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: width(context) / 20,
                    ),
                  ),
              SizedBox(height: 5.0),

              lieux.length == 0 ? SizedBox() :
              Container(
                height: width(context) / 4,
                width: width(context) / 1.15,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
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
                            color: Colors.black,
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
      ),
    );
  }
}