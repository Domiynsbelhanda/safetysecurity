import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:safetysecurity/Model/Invitation.dart';
import 'package:safetysecurity/Model/Users.dart';
import 'package:safetysecurity/View/ActivityPrincipale.dart';
import 'package:safetysecurity/globalsVariables.dart';

class Recherche extends SearchDelegate{

  final GlobalKey<ScaffoldState> _scaffoldKey;
  Recherche(this._scaffoldKey);

  @override
  List<Widget> buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          },
        ),
      ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List list = users
        .where(
            (user) => user.telephone.toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    // TODO: implement buildResults
    return Text(
      '${list.length}'
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List list = users
        .where(
            (user) => user.telephone.toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    List list2 = users
        .where(
            (user) => user.email.toLowerCase()
            .contains(query.toLowerCase()))
        .toList();

    List list3 = users
        .where(
            (user) => user.name.toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    List <Users> liste = [...list, ...list2, ...list3];

    liste.removeWhere((element) => element.id == currentFirebaseUser.uid);

    final ids = liste.map((e) => e.id).toSet();
    liste.retainWhere((x) => ids.remove(x.id));

    final invitids = invitations.map((e) => e.uid).toSet();
    invitations.retainWhere((x) => invitids.remove(x.uid));

    // TODO: implement buildResults
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: liste.map((e){
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                                    width: double.infinity,
                                    child: Row(
                                      children: [
                                        Container(
                                          height: width(context) / 10,
                                          child: CircleAvatar(
                                            radius: 30.0,
                                            backgroundImage:
                                            NetworkImage('${e.image}'),
                                            backgroundColor: Colors.transparent,
                                          ),
                                        ),

                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              '${e.name}',
                                              style: TextStyle(
                                                fontFamily: 'Roboto',
                                              ),
                                              textAlign: TextAlign.left,
                                            ),

                                            Text(
                                              '${e.email}',
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
                                  ),
                  ),

                  Expanded(
                    child: GestureDetector(
                              onTap: () async{

                                if (invitations.any((item) => item.destinataire.contains(e.id))){
                                  List<Invitation> invit = 
                                  invitations.where((element) => element.destinataire.contains(e.id)).toList();
                                  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                await
                                _firestore.collection('Invitations')
                                    .doc(invit.first.uid).delete();
                                  showInSnackBar('invitation annulée', _scaffoldKey, context);
                                  readData();
                                  Navigator.pop(context);
                                } else {
                                  var invitation = {
                                  'expeditaire': currentFirebaseUser.uid,
                                  'destinataire': e.id,
                                  'timestamp': FieldValue.serverTimestamp(),
                                  'vu': false,
                                  'accepte': false,
                                  'refuse': true
                                };
                                final FirebaseFirestore _firestore = FirebaseFirestore.instance;
                                await
                                _firestore.collection('Invitations')
                                    .add(invitation);
                                showInSnackBar('Vous avez envoyé une demande', _scaffoldKey, context);
                                readData();
                                Navigator.pop(context);
                                }
                              }, 
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5.0)
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Text(
                                    invitations.any((item) => item.destinataire.contains(e.id)) ?
                                    'Annuler la demande' : 'Envoyez une relation',
                                    style: TextStyle(
                                      color: Colors.blue
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            )
                  )
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}