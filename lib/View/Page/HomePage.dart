import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:safetysecurity/globalsVariables.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _HomePage();
  }
}

class _HomePage extends State<HomePage>{

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final FocusNode myTitreFocus = FocusNode();
  final FocusNode myDescriptionFocus = FocusNode();

  TextEditingController myTitreController = TextEditingController();
  TextEditingController myDescriptionController = TextEditingController();

  final formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          children: [
            entete(context),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  //Début de la publication
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Titre
                        Container(
                          width: double.infinity,
                          height: width(context) / 12.5,
                          child: TextField(
                            focusNode: myTitreFocus,
                            controller: myTitreController,
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                fontSize: width(context) / 25
                            ),
                            decoration: InputDecoration(
                                labelText: "Titre |",
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: const Color(0xff444d5e),
                                    )
                                )
                            ),
                          ),
                        ),

                        SizedBox(height: 10.0),

                        Container(
                          width: double.infinity,
                          height: width(context) / 5,
                          child: TextField(
                            focusNode: myDescriptionFocus,
                            controller: myDescriptionController,
                            keyboardType: TextInputType.multiline,
                            style: TextStyle(
                                fontSize: width(context) / 25
                            ),
                            decoration: InputDecoration(
                                labelText: "Description |",
                                border: new OutlineInputBorder(
                                    borderSide: new BorderSide(
                                      color: const Color(0xff444d5e),
                                    )
                                )
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Choix des images ou videos et de la date des faits
                  Container(
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
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff99c0e1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.image,
                                      color: const Color(0xff444d5e),
                                      size: width(context) / 15,
                                    ),
                                    Text(
                                      '  Image'
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0),

                        Expanded(
                          child: GestureDetector(
                            onTap: (){},
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff99c0e1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.video,
                                      color: const Color(0xff444d5e),
                                      size: width(context) / 15,
                                    ),
                                    Text(
                                        '  Video'
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0),

                        Expanded(
                          child: GestureDetector(
                            onTap: (){},
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: const Color(0xff99c0e1),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.calendarAlt,
                                      color: const Color(0xff444d5e),
                                      size: width(context) / 15,
                                    ),
                                    Text(
                                        '  Date'
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}