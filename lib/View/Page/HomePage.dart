import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
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

  String times;

  String sampleImage;

  final ImagePicker _picker = ImagePicker();

  Future getImage() async{
    XFile tempImage = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      sampleImage = tempImage.path;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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

                  DateTimePicker(
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    icon: Icon(Icons.event),
                    dateLabelText: 'Date',
                    timeLabelText: "Heure",
                    selectableDayPredicate: (date) {
                      // Disable weekend days to select from the calendar
                      if (date.weekday == 6 || date.weekday == 7) {
                        return false;
                      }

                      return true;
                    },
                    onChanged: (val) {
                      times = val;
                    },
                    validator: (val) {
                      times = val;
                      return null;
                    },
                    onSaved: (val) {
                      times = val;
                    },
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
                            onTap: getImage,
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
                                      sampleImage == null ?
                                      '  Image' : '   Image ${'ok'}'
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
                            onTap: ()=> publierArticle(),
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
                                    Text(
                                        'Publier'
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

                ],
              ),
            ),

            SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'FIL D\'ACTUALITE',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: width(context) / 15,
                  decoration: TextDecoration.underline
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Column(
              children: articles.map((item){
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 5.0),
                    child: Column(
                      children: [
                        utilisateurs(context, item.id, item),
                        SizedBox(height: 5.0),
                        itemArticle(context, _scaffoldKey, item),
                        SizedBox(height: 5.0),
                        Divider(
                          height: 20.0,
                        )
                      ],
                    ),
                  );
                }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  publierArticle() async{

    if(myTitreController.text == null){
      showInSnackBar("Entrez un titre", _scaffoldKey, context);
      return;
    }

    if(myDescriptionController.text == null){
      showInSnackBar("Entrez une description", _scaffoldKey, context);
      return;
    }

    if(times == null){
      showInSnackBar("Selectionner une date", _scaffoldKey, context);
      return;
    }

    if(sampleImage == null){
      showInSnackBar("Selectionner une image", _scaffoldKey, context);
      return;
    }

    showDialogs("Patienter", context);
    String url;
    final Reference postImageRef = FirebaseStorage.instance.ref().child("Articles");
    final TaskSnapshot uploadTask = await postImageRef
        .child('${myTitreController.text}_${times}.png').putFile(File(sampleImage));
    var ImageUrl = await uploadTask.ref.getDownloadURL();
    url = ImageUrl.toString();
    Navigator.pop(context);

    var data = {
      'titre': myTitreController.text,
      'description': myDescriptionController.text,
      'date': times,
      'timestamp': FieldValue.serverTimestamp(),
      'id': currentFirebaseUser.uid,
      'image': url,
      'like': 0,
      'comment': 0
    };

    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    await
    _firestore.collection('Articles').add(data);
    showInSnackBar("publication effectuée.", _scaffoldKey, context);
  }
}