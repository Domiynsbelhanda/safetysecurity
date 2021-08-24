import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Recherche.dart';
import 'package:safetysecurity/Model/Amis.dart';
import 'package:safetysecurity/Model/Users.dart';
import 'package:safetysecurity/globalsVariables.dart';

import '../ActivityPrincipale.dart';

class YourFriends extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YourFriends();
  }
}

class _YourFriends extends State<YourFriends>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  String a;

  @override
  void initState() {
      // TODO: implement initState
      final ids = amis.map((e) => e.id).toSet();
      amis.retainWhere((x) => ids.remove(x.id));
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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'VOS AMIS',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: width(context) / 15,
                    letterSpacing: 2,
                  ),
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                ),
              ),

              SizedBox(height: 10.0),

              Center(child: button('AJOUTER', context, (){
                showSearch(
                  context: context,
                  delegate: Recherche(_scaffoldKey),
                );
              })),

              SizedBox(height: 5.0,),

              Divider(height: 5.0),

              Column(
                children: amis.map((el){
                  List<Users> vosAmis;
                  vosAmis = users.where((element) => element.id.contains(el.id)).toList();
                  return itemAmis(el, vosAmis.first);
                }).toList(),
              )
              
            ],
          ),
        ),
      ),
    );
  }

  Widget itemAmis(Amis item, Users us){
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
                    '${us.name}',
                    style: TextStyle(
                      fontSize: width(context) / 20
                    ),
                    textAlign: TextAlign.center,
                  ),

                  Text(
                    '${us.email}',
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
            FirebaseFirestore.instance
                  .collection("Users").doc(currentFirebaseUser.uid)
                  .collection('amis')
                  .doc(item.uid).delete();
              FirebaseFirestore.instance
                  .collection("Users").doc(us.id)
                  .collection('amis')
                  .doc(currentFirebaseUser.uid).delete();
              showInSnackBar('delete pressed', _scaffoldKey, context);

            Navigator.pop(context);
          },
        ),
      ),
    );
  }
}