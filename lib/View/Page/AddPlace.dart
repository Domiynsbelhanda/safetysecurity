import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:safetysecurity/Model/Lieu.dart';
import 'package:safetysecurity/View/ActivityPrincipale.dart';

import '../../globalsVariables.dart';

class AddPlace extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPlace();
  }
}

class _AddPlace extends State<AddPlace>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myDenominationFocus = FocusNode();
  final FocusNode myDescriptionFocus = FocusNode();

  TextEditingController myDenominationController = TextEditingController();
  TextEditingController myDescriptionController = TextEditingController();

  PickResult selectedPlace;
  static final kInitialPosition = LatLng(-33.8567844, 151.213108);

  List<Lieu> lieux = [];


  @override
  void initState() {
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
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              backButton(context),

            ],
          ),
        ),
        title: Text(
          'SAFETY SECURITY',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: width(context) / 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

              Text(
                'AJOUT D\'UN LIEU',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: width(context) / 15,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),

              SizedBox(height: 10.0),

              Container(
                width: double.infinity,
                height: width(context) / 12.5,
                child: TextField(
                  focusNode: myDenominationFocus,
                  controller: myDenominationController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontSize: width(context) / 25
                  ),
                  decoration: InputDecoration(
                      labelText: "Denomination |",
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: const Color(0xff444d5e),
                          )
                      )
                  ),
                ),
              ),

              SizedBox(height: 10.0),

              Container(
                width: double.infinity,
                height: width(context) / 5,
                child: TextField(
                  focusNode: myDescriptionFocus,
                  controller: myDescriptionController,
                  keyboardType: TextInputType.multiline,
                  style: TextStyle(
                      fontSize: width(context) / 25
                  ),
                  decoration: InputDecoration(
                      labelText: "Description |",
                      border: new OutlineInputBorder(
                          borderSide: new BorderSide(
                            color: const Color(0xff444d5e),
                          )
                      )
                  ),
                ),
              ),

              SizedBox(height: 5.0),

              TextButton(
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacePicker(
                        apiKey: apiKey,   // Put YOUR OWN KEY here.
                        onPlacePicked: (result) {
                          setState(() {
                            selectedPlace = result;
                          });
                          Navigator.of(context).pop();
                        },
                        initialPosition: kInitialPosition,
                        useCurrentLocation: true,
                      ),
                    ),
                  );
                },
                child: selectedPlace == null ?
                Text('Selectionner une place sur la carte')
                    : Text('${selectedPlace.formattedAddress}' ?? " / Cliquez pour changer."),
              ),

              GestureDetector(
                onTap: () async{
                  if(myDenominationController.text.isEmpty){
                    showInSnackBar('Entrez une denomination', _scaffoldKey, context);
                    return;
                  }

                  if(myDescriptionController.text.isEmpty){
                    showInSnackBar('Entrez une description', _scaffoldKey, context);
                    return;
                  }

                  if(selectedPlace == null){
                    showInSnackBar('Veuillez choisir la position', _scaffoldKey, context);
                    return;
                  }

                  var data = {
                    'adresse': selectedPlace.formattedAddress,
                    'timestamp': FieldValue.serverTimestamp(),
                    'longitude': selectedPlace.geometry.location.lng,
                    'latitude': selectedPlace.geometry.location.lat,
                    'placeId': selectedPlace.placeId,
                    'denomination': myDenominationController.text,
                    'description': myDescriptionController.text
                  };

                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                  await
                  _firestore.collection('Users')
                      .doc(currentFirebaseUser.uid)
                      .collection('lieux').add(data);
                  showInSnackBar("Lieu ajouté.", _scaffoldKey, context);
                },
                child: Container(
                  height: width(context) / 10,
                  decoration: BoxDecoration(
                    color: const Color(0xff99c0e1),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            'Publier'
                        )
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 5.0),

              Divider(height: 20.0,),

              Text(
                'VOS LIEUX',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: width(context) / 15,
                  letterSpacing: 4,
                  decoration: TextDecoration.underline
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 10.0),

              Column(
                children: lieux.map((e){
                  return itemLieu(e);
                }).toList()
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget itemLieu(Lieu lieu){
    return Padding(
      padding: const EdgeInsets.only(bottom:10.0),
      child: Container(
        margin: EdgeInsets.only(top: 3.0, bottom: 3.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xff99c0e1),
          borderRadius: BorderRadius.circular(50.0)
        ),
        child: Chip(
          deleteIconColor: Colors.red,
          backgroundColor: Colors.transparent,
          clipBehavior: Clip.none,
          label: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(
              width: width(context) / 1.5,
              child: Column(
                children: [
                  Text(
                    '${lieu.denomination}',
                    style: TextStyle(
                      fontSize: width(context) / 20
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    '${lieu.adresse}',
                    style: TextStyle(
                        fontSize: width(context) / 20
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          deleteIcon: Icon(
            FontAwesomeIcons.trashAlt
          ),
          onDeleted: (){
            setState(() {
              FirebaseFirestore.instance
                  .collection("Users").doc(currentFirebaseUser.uid)
                  .collection('lieux')
                  .doc(lieu.id).delete();
              showInSnackBar('delete pressed', _scaffoldKey, context);
            });
          },
        ),
      ),
    );
  }
}