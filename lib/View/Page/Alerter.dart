import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
              showInSnackBar('${position.latitude}', _scaffoldKey, context);
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