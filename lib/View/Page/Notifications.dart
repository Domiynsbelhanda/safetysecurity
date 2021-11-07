import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safetysecurity/Model/Alerte.dart';
import 'package:safetysecurity/Model/Invitation.dart';
import 'package:safetysecurity/Model/Users.dart';

import '../../globalsVariables.dart';
import '../ActivityPrincipale.dart';
import '../GoogleMaps.dart';
import 'UserProfil.dart';

import 'package:timeago/timeago.dart' as timeago;

class Notifications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Notifications();
  }
}

class _Notifications extends State<Notifications>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Invitation> invit = [];
  List alerte = [];

  @override
  void initState() {
    alerte = alertes;
    invit = invitations.where((element) => element.destinataire.contains(currentFirebaseUser.uid)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: floatingAlert(context),
      appBar: AppBar(
        elevation: 3.0,
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
          'Notifications',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: 18.0,
            color: couleurText,
            fontWeight: FontWeight.normal,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context){
                  return UserProfil();
                }
              )
              );
            },
            child: Container(
              height: 40.0,
              width: 40.0,
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                  NetworkImage('${currentUsers.image}'),
                  backgroundColor: Colors.transparent,
                ),
              ),
          ),

            SizedBox(width: 16.0)
        ],
      ),
      body: SingleChildScrollView(
        child: alertes.toString() == "null" && invit.toString() == 'null' ? 
        Text('Vous avez aucune notification') : 
        invit.length == 0 ?
        aDevant() :
        alerte.length == 0 ?
        iDevant() :
        alertes[0]?.timestamp.toDate().isAfter(invit[0]?.timestamp.toDate()) ?
        aDevant() : iDevant()
      ),
    );
  }

  Widget aDevant(){
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.0,),
            invit.length == 0 && alertes.length == 0 ? 
            Text('Vous avez aucune notification') : 
            Container(),

            Column(
              children: alertes.map((e) {
                if(e.vue){
                  return Text('');
                } else {
                  return alert(e);
                }
              }).toList(),
            ),

            Column(
              children: invit.map((e) {
                return invitation(e);
              }).toList(),
            )
          ],
    );
  }

  Widget iDevant(){
    return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.0,),
            invit.length == 0 && alertes.length == 0 ? 
            Text('Vous avez aucune notification') : 
            Container(),

            Column(
              children: invit.map((e) {
                return invitation(e);
              }).toList(),
            ),

            Column(
              children: alertes.map((e) {
                if(e.vue){
                  return Text('');
                } else {
                  return alert(e);
                }
              }).toList(),
            )
          ],
        );
  }

  Widget invitation(Invitation item){
    List<Users> us = users.where((element) => element.id.contains(item.expeditaire)).toList();
    Users itemUser = us.first;

    var times = timeago.format(item.timestamp.toDate());

    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 76.0,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56.0),
                image: DecorationImage(
                  image: NetworkImage('${itemUser.image}'),
                  fit: BoxFit.cover
                )
              ),
              height: 56.0,
              width: 56.0,
            ),
            SizedBox(width: 16.0,),

            Container(
              width: width(context) - (56 + 16 + 16 +20),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text : '${itemUser.name.toUpperCase()}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          color: couleurPrimaire
                        ),
                        children: [
                          TextSpan(
                            text: ' vous a envoyé une invitation :',
                            style: TextStyle(
                              color: couleurText
                            )
                          ),

                          TextSpan(
                            text: ' ${times}',
                            style: TextStyle(
                              color: couleurSecondaire
                            )
                          )
                        ]
                      ),
                    ),

                    SizedBox(height: 8.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () async{
                              var data = {
                                'id': item.expeditaire,
                              };

                              final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                              await
                              _firestore.collection('Users')
                                  .doc(currentFirebaseUser.uid)
                                  .collection('amis').doc(item.expeditaire)
                                  .set(data);
                              
                              var datas = {
                                'id': currentFirebaseUser.uid,
                              };

                              await
                              _firestore.collection('Users')
                                  .doc(item.expeditaire)
                                  .collection('amis').doc(currentFirebaseUser.uid)
                                  .set(datas);
                              
                              await
                                    _firestore.collection('Invitations')
                                        .doc(item.uid).delete();

                              setState(() {
                                invit = invitations;
                              });
                              showInSnackBar('Invitation acceptée', _scaffoldKey, context);
                            
                            },
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: couleurPrimaire,
                                  width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Text(
                                'Accepter'
                              ),
                            ),
                          )
                        ),

                        SizedBox(width: 8.0,),

                        Container(
                          child: GestureDetector(
                            onTap: () async{
                              final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                    await
                                    _firestore.collection('Invitations')
                                        .doc(item.uid).delete();
                              showInSnackBar('Invitation refusée', _scaffoldKey, context);
                              setState(() {
                                invit = invitations;
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: couleurSecondaire,
                                  width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Text(
                                'Refuser',
                                style: TextStyle(
                                  color: couleurSecondaire
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget alert(Alerte item){
    List<Users> us = users.where((element) => element.id.contains(item.de)).toList();
    Users itemUser = us.first;

    var times = timeago.format(item.timestamp.toDate());
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Container(
        height: 76.0,
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(56.0),
                image: DecorationImage(
                  image: NetworkImage('${itemUser.image}'),
                  fit: BoxFit.cover
                )
              ),
              height: 56.0,
              width: 56.0,
            ),
            SizedBox(width: 16.0,),

            Container(
              width: width(context) - (56 + 16 + 16 +20),
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Column(
                  children: [
                    RichText(
                      text: TextSpan(
                        text : '${itemUser.name.toUpperCase()}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: 14.0,
                          color: couleurPrimaire
                        ),
                        children: [
                          TextSpan(
                            text: ' vous a envoyé une alerte :',
                            style: TextStyle(
                              color: couleurText
                            )
                          ),

                          TextSpan(
                            text: ' ${times}',
                            style: TextStyle(
                              color: couleurSecondaire
                            )
                          )
                        ]
                      ),
                    ),

                    SizedBox(height: 8.0,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          child: GestureDetector(
                            onTap: () async{
                              
                              showInSnackBar('Alertes vue', _scaffoldKey, context);

                              Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return MapsView(alerte: item);
                                    })
                                );
                            }, 
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: couleurPrimaire,
                                  width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Text(
                                'Voir sur la carte',
                                style: TextStyle(
                                  color: couleurPrimaire,
                                  fontSize: 14.0
                                ),
                              ),
                            )
                          ),
                        ),

                        SizedBox(width: 8.0,),

                        Container(
                          child: GestureDetector(
                            onTap: () async{
                              final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                    await
                                    _firestore.collection('Users')
                                        .doc(currentFirebaseUser.uid)
                                        .collection('alertes')
                                        .doc(item.id)
                                        .update({'vue': true});
                              showInSnackBar('Alertes vue', _scaffoldKey, context);
                              Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return HomeScreen(index: 0,);
                                    })
                                );
                            }, 
                            child: Container(
                              padding: EdgeInsets.all(3.0),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: couleurSecondaire,
                                  width: 2.0
                                ),
                                borderRadius: BorderRadius.circular(3.0),
                              ),
                              child: Text(
                                'Refuser',
                                style: TextStyle(
                                  color: couleurSecondaire
                                ),
                              ),
                            )
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}