import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:safetysecurity/Model/Alerte.dart';
import 'package:safetysecurity/Model/Amis.dart';
import 'package:safetysecurity/Model/Invitation.dart';
import 'package:safetysecurity/View/Page/ArticleItemDetails.dart';

import 'Controller/ProgressDialog.dart';
import 'Model/Articles.dart';
import 'Model/Commentaires.dart';
import 'Model/Users.dart';
import 'View/Page/Alerter.dart';

double width(context) {
  return MediaQuery.of(context).size.width;
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

User currentFirebaseUser;

List<Articles> articles = [];
List<Users> users;
Users currentUsers;
List<Invitation> invitations;
List<Amis> amis;
List<Alerte> alertes;

String apiKey = 'AIzaSyCXD9g7N4ntnTdM81_h9JpphvaMXtdFTmw';

Position position;

Widget entete(context) {
  return Container(
    height: height(context) / 4,
    width: double.infinity,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(""
            "https://firebasestorage.googleapis.com/v0/b/car-rental-rdc.appspot.com/o/vector1.png?alt=media&token=e91b326c-87df-429d-b08b-fef5eef79a75"),
        fit: BoxFit.cover,
      )
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'SAFETY SECURITY',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: width(context) / 16,
          color: const Color(0xff4e392a),
          fontWeight: FontWeight.w700,
        ),
        textAlign: TextAlign.center,
      ),
    )
  );
}

Widget button(text, context, function){
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(5.0),
      color: Colors.blue,
    ),
    child: TextButton(
      onPressed: function,
      child: Text(
        '${text}',
        style: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 16,
          color: Colors.white,
          fontWeight: FontWeight.w700,
          height: 1.0625,
        ),
        textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
        textAlign: TextAlign.center,
      ),
    ),
  );
}

void showInSnackBar(String value, _scaffoldKey, context) {
  FocusScope.of(context).requestFocus(new FocusNode());
  _scaffoldKey.currentState?.removeCurrentSnackBar();
  _scaffoldKey.currentState.showSnackBar(new SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Colors.white,
        fontSize: 16.0,),
    ),
    backgroundColor: Colors.blue,
    duration: Duration(seconds: 3),
  ));
}

showDialogs(String text, context){
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) => ProgressDialog(status: text),
  );
}

Widget itemArticle(context, _scaffoldKey, Articles item){
  return Container(
    width: double.infinity,
    height: 306,
    child: Column(
      children: [

        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        '${item.titre.toUpperCase()}',
                        style: TextStyle(
                          fontSize: 17.0,
                          color: couleurText,                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 8.0,
                ),
                Text(
                  '${item.description}',
                  style: TextStyle(
                    fontSize: 13.0,
                    color: couleurText,
                  ),
                ),
              ],
            ),
          ),
        ),

        Expanded(
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                height: 185,
                width: double.infinity,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                          '${item.image}'
                      ),
                    )
                ),
              ),
            ]
          ),
        ),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            InkWell(
              onTap: () {
                  FirebaseFirestore.instance.collection('Articles').doc(item.uid)
                    .update({"like": FieldValue.increment(1)});
                  FirebaseFirestore.instance.collection('Articles').doc(item.uid).collection('like')
                  .doc(currentUsers.id).set({'uid' : currentUsers.id});
                showInSnackBar("Vous avez likés", _scaffoldKey, context);
                Navigator.popAndPushNamed(context, '/home');
              },
              child: Container(
                width: 60.0,
                height: 45.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.solidHeart,
                      color: couleurPrincipale,
                    ),

                    Text(
                        '   ${item.like}',
                        style: TextStyle(
                            color: Colors.black
                        )
                    ),
                  ],
                ),
              ),
            ),

            GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context){
                      return ItemDetails(comment: true, item: item,);
                    })
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          FontAwesomeIcons.comment,
                          color: Colors.black,
                          size: width(context) / 15,
                        ),
                        Text(
                            '   Commenter',
                            style: TextStyle(
                                color: Colors.black
                            )
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        )
      ],
    ),
  );
}

Widget utilisateurs(context, id, item){

  List<Users> utilisateurs = users
      .where(
          (doc) => doc.id.toLowerCase()
          .contains(id.toLowerCase()))
      .toList();
  return Container(
    height: width(context) / 8,
    width: double.infinity,
    child: Row(
      children: [
        Container(
          child: CircleAvatar(
            radius: 30.0,
            backgroundImage:
            NetworkImage('${utilisateurs[0].image}'),
            backgroundColor: Colors.transparent,
          ),
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${utilisateurs[0].name}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: width(context) / 20,
                color: couleurText,
                fontWeight: FontWeight.bold
              ),
              textAlign: TextAlign.left,
            ),

            Text(
              '${item.date}',
              style: TextStyle(
                fontFamily: 'Roboto',
                fontSize: width(context) / 26,
                fontStyle: FontStyle.italic,
                color: couleurText
              ),
              textAlign: TextAlign.left,
            )
          ],
        )
      ],
    ),
  );
}

Widget backButton(context){
  return GestureDetector(
    onTap: (){
      Navigator.pop(context);
    },
    child: Container(
      width: 28,
      height: 28,
      child: Icon(
        FontAwesomeIcons.arrowLeft,
        color: couleurNeutre,
        size: 20,
      ),
    ),
  );
}


Widget item(String text, IconData icon, VoidCallback press){
    return  Container(
      height: 140.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.black.withOpacity(0.5)
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 50.0,
            width: 50.0,
            child: ClipOval(
              clipBehavior: Clip.antiAlias,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.transparent,
                      Colors.orange.withOpacity(0.5),
                      Colors.amber,
                      couleurPrincipale
                    ]
                  ),
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(color: Colors.amber)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3.0),
                  child: ClipOval(
                    clipBehavior: Clip.antiAlias,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25)
                      ),
                      child: Center(
                        child: FlatButton(
                          onPressed: press,
                          child: Icon(
                            icon,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 8.0),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              text.toLowerCase(),
              style: TextStyle(
                color: Colors.white
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }


Widget floatingAlert(context){
  return GestureDetector(
        onTap: (){
          Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context){
                                  return Alerter();
                                })
                            );
        },
        child: Container(
          height: 56.0,
          width: 56.0,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(56),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                couleurPrincipale,
                Colors.amber,
              ]
            )
          ),
          child: Image.asset(
            'assets/img/cloche.png',
            height: 23.57,
            width: 20.0,
          ),
        ),
      );
}
const Color couleurPrincipale = const Color(0Xfffccd04);
const Color couleurSecondaire = const Color(0Xfffc041c);
const Color couleurNeutre = const Color(0Xff787E82);
const Color couleurPrimaire = const Color(0Xff00B2FF);
const Color couleurSuccess = const Color(0Xff00FF94);
const Color couleurText = const Color(0xff556974);