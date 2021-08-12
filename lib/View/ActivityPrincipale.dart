import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/Controller/Authentification.dart';
import 'package:safetysecurity/globalsVariables.dart';

import 'Page/HomePage.dart';

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
}