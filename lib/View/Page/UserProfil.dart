import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Authentification.dart';
import 'package:safetysecurity/Model/Amis.dart';
import 'package:safetysecurity/Model/Lieu.dart';
import 'package:safetysecurity/Model/Users.dart';
import 'package:safetysecurity/View/Connexion.dart';
import 'package:safetysecurity/View/Page/YourFriends.dart';
import 'package:safetysecurity/View/Page/YourPublication.dart';

import '../../globalsVariables.dart';
import 'AddPlace.dart';
import 'Alerter.dart';
import 'Notifications.dart';

class UserProfil extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _UserProfil();
  }
}

class _UserProfil extends State<UserProfil>{

  Authentifications authentifications = new Authentifications();

  List<Lieu> lieux = [];
  String a;

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

    // TODO: implement initState
    final ids = amis.map((e) => e.id).toSet();
    amis.retainWhere((x) => ids.remove(x.id));
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: floatingAlert(context),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 5.0,
        iconTheme: IconThemeData(
          color: couleurNeutre
        ),
        title: Text(
            'Mon Profil',
          style: TextStyle(
            color: couleurText,
            fontWeight: FontWeight.w400,
            fontSize: 20.0
          ),
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
            child: Container(
              height: 40.0,
              width: 40.0,
              child: Icon(
                    Icons.notifications,
                    color: couleurNeutre,
                    size: 24
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
            child: Icon(
                  Icons.settings,
                  color: couleurNeutre,
                  size: 30
              ),
          ),

          SizedBox(width: 16.0,)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: EdgeInsets.only(top: height(context) / 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: width(context) / 3,
                            width: width(context) / 3,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                              NetworkImage('${currentUsers.image}'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),

                          SizedBox(height: 8.0,),

                          Text(
                            '${currentUsers.name}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 24.0,
                              fontWeight: FontWeight.w400,
                              color: couleurNeutre
                            ),
                          ),

                          Text(
                            '${currentUsers.email}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: couleurText
                            ),
                          ),

                          Text(
                            '${currentUsers.telephone}',
                            style: TextStyle(
                              fontFamily: 'Roboto',
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                              color: couleurText
                            ),
                          ),

                          SizedBox(height: 16.0),

                          Padding(
                            padding: const EdgeInsets.only(left: 60.0, right: 60.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: couleurPrimaire),
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      ' Editer',
                                      style: TextStyle(
                                          color: couleurPrimaire,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ),
                              )
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0),

              Padding(
                padding: EdgeInsets.all(16.0),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: couleurPrincipale.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.0)
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Adresses',
                            style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              color: Color(0Xff43462E)
                            ),
                            textAlign: TextAlign.start,
                          ),

                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context){
                                    return AddPlace();
                                  })
                              );
                            },
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                    'Ajouter',
                                    style: TextStyle(
                                        color: couleurPrimaire,
                                        fontWeight: FontWeight.normal,
                                      fontSize: 14.0
                                    )
                                ),
                              ),
                            ),
                          )
                        ],
                      ),

                      Column(
                        children: lieux.map((Lieu e){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Icon(
                                  FontAwesomeIcons.home,
                                  color: Colors.black,
                                  size: width(context) / 18,
                                ),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Text(
                                    '${e.adresse}',
                                    style: TextStyle(
                                        fontSize: width(context) / 18
                                    ),
                                  ),
                                  )
                              ],
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  )
                ),
              ),

              Padding(
                padding: EdgeInsets.all(15.0),
                child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0)
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Vos Proches',
                              style: TextStyle(
                                fontSize: width(context) / 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.start,
                            ),

                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return YourFriends();
                                    })
                                );
                              },
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'Ajouter',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.normal,
                                          fontSize: width(context) / 20
                                      )
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),

                        Text(
                          '${amis.length} Proches'
                        ),

                        Container(
                          width: double.infinity,
                          height: width(context) / 2,
                          child: ListView(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            children: amis.map((Amis e){
                              List<Users> vosAmis;
                              vosAmis = users.where((element) => element.id.contains(e.id)).toList();
                              return Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: width(context) / 2,
                                      height: width(context) / 2,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            '${vosAmis.first.image}'
                                          )
                                        )
                                      ),
                                    ),
                                    Container(
                                      width: width(context) / 2,
                                      height: width(context) / 2,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        color: Colors.white,
                                        gradient: LinearGradient(
                                          begin: FractionalOffset.topCenter,
                                          end: FractionalOffset.bottomCenter,
                                          colors: [
                                            Colors.grey.withOpacity(0.0),
                                            Colors.orangeAccent.withOpacity(0.8)
                                          ],
                                          stops: [
                                            0.0,
                                            1.0
                                          ]
                                        )
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                            '${vosAmis.first.name.toUpperCase()}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                          ),
                                        ),
                                      )
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    )
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: width(context) / 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'VOS ALERTES',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ),
                              )
                          ),
                        ),
                      ),

                      SizedBox(width: 10.0),

                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return YourPublication();
                                })
                            );
                          },
                          child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.transparent,
                                  border: Border.all(color: Colors.lightBlue),
                                  borderRadius: BorderRadius.circular(15.0)
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                      'VOS PUBLICATIONS',
                                      style: TextStyle(
                                          color: Colors.lightBlue,
                                          fontWeight: FontWeight.normal
                                      )
                                  ),
                                ),
                              )
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.all(20.0),
                child: GestureDetector(
                  onTap: (){
                    authentifications.signOut(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context){
                          return Authentification();
                        })
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50.0, right: 50.0),
                    child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(color: Colors.lightBlue),
                            borderRadius: BorderRadius.circular(15.0)
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                                'DECONNEXION',
                                style: TextStyle(
                                    color: Colors.lightBlue,
                                    fontWeight: FontWeight.normal
                                )
                            ),
                          ),
                        )
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.0)
            ],
          ),
        ),
      ),
    );
  }
}