import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Authentification.dart';
import 'package:safetysecurity/globalsVariables.dart';

import 'Page/HomePage.dart';
import '../Model/Articles.dart';
import '../Model/Users.dart';

class HomeScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomeScreen();
  }
}

class _HomeScreen extends State<HomeScreen>{

  Authentifications auth = Authentifications();

  int _currentIndex = 0;
  PageController _pageController;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        bottomNavigationBar: BottomNavyBar(
          backgroundColor: Colors.white,
          selectedIndex: _currentIndex,
          showElevation: true, // use this to remove appBar's elevation
          onItemSelected: (index) => setState(() {
            _currentIndex = index;
          }),
          items: [
            BottomNavyBarItem(
              icon: Icon(
                FontAwesomeIcons.home,
                color: const Color(0xff444d5e),
              ),
              title: Text(
                  '  Accueil',
                style: TextStyle(
                  color: const Color(0xff444d5e),
                ),
              ),
              activeColor: Colors.lightBlue,
            ),
            BottomNavyBarItem(
                icon: Icon(
                    FontAwesomeIcons.plusCircle,
                  color: const Color(0xff444d5e),
                ),
                title: Text(
                    '   Alerter',
                  style: TextStyle(
                    color: const Color(0xff444d5e),
                  ),
                ),
                activeColor: Colors.lightBlue
            ),
            BottomNavyBarItem(
                icon: Icon(
                    FontAwesomeIcons.user,
                  color: const Color(0xff444d5e),
                ),
                title: Text(
                    '   Profil',
                  style: TextStyle(
                    color: const Color(0xff444d5e),
                  ),
                ),
                activeColor: Colors.lightBlue
            ),
            BottomNavyBarItem(
                icon: Icon(
                    FontAwesomeIcons.sun,
                  color: const Color(0xff444d5e),
                ),
                title: Text(
                    '   Paramètre',
                  style: TextStyle(
                    color: const Color(0xff444d5e),
                  ),
                ),
                activeColor: Colors.lightBlue
            ),
          ],
        ),
        body: pages.elementAt(_currentIndex)
    );
  }

  List pages = [
    HomePage(),
    HomePage(),
    HomePage(),
    HomePage(),
  ];

  @override
  void initState() {
    articles = [];

    Query collectionReference1 = FirebaseFirestore.instance
        .collection("Articles")
        .orderBy('timestamp', descending: true);


    collectionReference1
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {

      articles.add(
          new Articles(
            titre: doc.get('titre'),
            description: doc.get("description"),
            id: doc.get('id'),
            date: doc.get('date'),
            image: doc.get('image'),
            timestamp: doc.get('timestamp'),
            like: doc.get('like'),
            comment: doc.get('comment'),
            uid: doc.id
          )
      );
    })
    );

    users = [];

    Query collectionReference = FirebaseFirestore.instance
        .collection("Users")
        .orderBy('name', descending: true);


    collectionReference
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {

      users.add(
          new Users(
              key: doc.get('key'),
              name: doc.get("name"),
              email: doc.get('email'),
              image: doc.get('image'),
              password: doc.get('password'),
              telephone: doc.get('telephone'),
              id: doc.id,
          )
      );
    })
    );

    String userid = currentFirebaseUser.uid;

    FirebaseFirestore.instance.collection('Users').doc('${userid}').snapshots()
        .forEach((element) {
      setState(() {
        currentUsers = Users(
            key: element.data()['key'],
            email: element.data()['email'],
            image: element.data()['image'],
            name: element.data()['name'],
            telephone: element.data()['telephone'],
            password: element.data()['password'],
            id: element.id
        );
      });
    });
    super.initState();
  }
}