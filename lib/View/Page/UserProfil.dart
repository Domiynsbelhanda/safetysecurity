import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Authentification.dart';
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        title: Text(
            'Mon Profil',
          style: TextStyle(
            color: Colors.black
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
            child: IconButton(
              icon: Icon(
                  Icons.notifications,
                  color: Colors.black,
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
                  color: Colors.black,
                  size: width(context) / 10
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
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

                        SizedBox(height: 10.0,),

                        Text(
                          '${currentUsers.name.toUpperCase()}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width(context) / 15,
                            fontWeight: FontWeight.normal,
                            height: 1.0625,
                            letterSpacing: 2,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          '${currentUsers.email}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width(context) / 20,
                            height: 1.0625,
                            letterSpacing: 0,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),

                        Text(
                          '${currentUsers.telephone}',
                          style: TextStyle(
                            fontFamily: 'Roboto',
                            fontSize: width(context) / 20,
                            height: 1.0625,
                            letterSpacing: 3.0,
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: 20.0),

                        Padding(
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
                                    '  MODIFIER',
                                    style: TextStyle(
                                        color: Colors.lightBlue,
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

            SizedBox(height: 10.0),

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
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context){
                                return YourFriends();
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
                                    '  VOS AMIS',
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
                                return AddPlace();
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
                                    '  VOS LIEUX',
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
    );
  }
}