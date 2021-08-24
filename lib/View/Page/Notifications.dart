import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:safetysecurity/Model/Alerte.dart';
import 'package:safetysecurity/Model/Invitation.dart';
import 'package:safetysecurity/Model/Users.dart';

import '../../globalsVariables.dart';
import '../ActivityPrincipale.dart';
import '../GoogleMaps.dart';

class Notifications extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _Notifications();
  }
}

class _Notifications extends State<Notifications>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Invitation> invit;

  @override
  void initState() {
    invit = invitations.where((element) => element.destinataire.contains(currentFirebaseUser.uid)).toList();
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10.0,),
            invit.length == 0 && alertes.length == 0 ? 
            Center(child: Text('Vous avez aucune notification')) : 
            Center(child: Text('Vos notifications :')),

            SizedBox(height: 5.0,), 

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
        ),
      ),
    );
  }

  Widget invitation(Invitation item){
    List<Users> us = users.where((element) => element.id.contains(item.expeditaire)).toList();
    Users itemUser = us.first;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffe3f2fd),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Vous avez une invitation de : '
              ),

              SizedBox(height: 3.0),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: width(context) / 10,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                      NetworkImage('${itemUser.image}'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${itemUser.name}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.left,
                      ),

                      Text(
                        '${itemUser.email}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: width(context) / 30,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () async{

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
                          decoration: BoxDecoration(
                            color: const Color(0xffe3f2fd),
                          ),
                          child: Text(
                            'ACCEPTER'
                          ),
                        )
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () async{
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
                          child: Text(
                            'REFUSER',
                            style: TextStyle(
                              color: const Color(0xffbf360c)
                            ),
                          ),
                        )
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  Widget alert(Alerte item){
    List<Users> us = users.where((element) => element.id.contains(item.de)).toList();
    Users itemUser = us.first;
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xffe3f2fd),
          borderRadius: BorderRadius.circular(5.0)
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'Vous avez une alerte de : '
              ),

              SizedBox(height: 3.0),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: width(context) / 10,
                    child: CircleAvatar(
                      radius: 30.0,
                      backgroundImage:
                      NetworkImage('${itemUser.image}'),
                      backgroundColor: Colors.transparent,
                    ),
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${itemUser.name}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                        ),
                        textAlign: TextAlign.left,
                      ),

                      Text(
                        '${itemUser.email}',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontSize: width(context) / 30,
                          fontStyle: FontStyle.italic,
                        ),
                        textAlign: TextAlign.left,
                      )
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () async{
                          
                          showInSnackBar('Alertes vue', _scaffoldKey, context);

                          Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return MapsView(alerte: item);
                                })
                            );
                        }, 
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xffe3f2fd),
                          ),
                          child: Text(
                            'Voir sur la carte'
                          ),
                        )
                      ),
                    ),
                  ),

                  Expanded(
                    child: Container(
                      child: TextButton(
                        onPressed: () async{
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
                          child: Text(
                            'Vue',
                            style: TextStyle(
                              color: const Color(0xffbf360c)
                            ),
                          ),
                        )
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}