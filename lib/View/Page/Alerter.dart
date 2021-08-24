import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/View/ActivityPrincipale.dart';

import '../../globalsVariables.dart';

class Alerter extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Alerter();
  }
}

class _Alerter extends State<Alerter>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            entete(context),

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

            item('ALERTER SUR UN DE VOS LIEUX', FontAwesomeIcons.houseUser, (){

            }),

            SizedBox(height: 5.0,),

            item('ALERTER SUR UNE POSITION', FontAwesomeIcons.mapMarkedAlt, (){
              
            }),
          ],
        ),
      ),
    );
  }
}