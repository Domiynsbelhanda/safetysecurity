import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Authentification.dart';
import 'package:safetysecurity/View/Connexion.dart';
import 'package:safetysecurity/View/Page/YourPublication.dart';

import '../../globalsVariables.dart';
import 'AddPlace.dart';

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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Stack(
              children: [
                entete(context),

                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: height(context) / 8),
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
                            fontWeight: FontWeight.w700,
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

                        Divider(
                          height: 5.0
                        ),

                        Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: GestureDetector(
                              onTap: (){

                              },
                              child: Container(
                                width: double.infinity,
                                height: width(context) / 10,
                                decoration: BoxDecoration(
                                  color: const Color(0xff99c0e1),
                                ),
                                child: Center(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.penSquare,
                                        color: const Color(0xff444d5e),
                                        size: width(context) / 15,
                                      ),
                                      Text(
                                          '  MODIFIER'
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
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
                        onTap: (){},
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xff99c0e1),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.users,
                                  color: const Color(0xff444d5e),
                                  size: width(context) / 15,
                                ),
                                Text(
                                    '  Vos Proches'
                                )
                              ],
                            ),
                          ),
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
                            color: const Color(0xff99c0e1),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.placeOfWorship,
                                  color: const Color(0xff444d5e),
                                  size: width(context) / 15,
                                ),
                                Text(
                                    '  Vos Lieux'
                                )
                              ],
                            ),
                          ),
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
                            color: const Color(0xff99c0e1),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.exclamationTriangle,
                                  color: const Color(0xff444d5e),
                                  size: width(context) / 15,
                                ),
                                Text(
                                    '  Vos Alertes'
                                )
                              ],
                            ),
                          ),
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
                            color: const Color(0xff99c0e1),
                          ),
                          child: Center(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  FontAwesomeIcons.bookReader,
                                  color: const Color(0xff444d5e),
                                  size: width(context) / 15,
                                ),
                                Text(
                                    '  Vos Publications'
                                )
                              ],
                            ),
                          ),
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
                child: Container(
                  width: double.infinity,
                  height: width(context) / 10,
                  decoration: BoxDecoration(
                    color: const Color(0xff99c0e1),
                  ),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.signOutAlt,
                          color: const Color(0xff444d5e),
                          size: width(context) / 15,
                        ),
                        Text(
                            '  Deconnexion'
                        )
                      ],
                    ),
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