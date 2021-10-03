import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:safetysecurity/Model/Alerte.dart';
import 'package:safetysecurity/Model/Amis.dart';
import 'package:safetysecurity/Model/Articles.dart';
import 'package:safetysecurity/Model/Invitation.dart';
import 'package:safetysecurity/Model/Users.dart';
import 'package:safetysecurity/View/ActivityPrincipale.dart';
import 'package:safetysecurity/globalsVariables.dart';

import 'Alerter.dart';
import 'ArticleItemDetails.dart';
import 'UserProfil.dart';

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

  getPosition() async {
    position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  @override
  void initState() {
    getPosition();

    articles = [];

    Query collectionReference1 = FirebaseFirestore.instance
        .collection("Articles")
        .orderBy('timestamp', descending: true);


    collectionReference1
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {

      setState(() {
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
      });
    })
    );

    users = [];

    Query collectionReference = FirebaseFirestore.instance
        .collection("Users")
        .orderBy('name', descending: true);


    collectionReference
        .snapshots()
        .listen((data) => data.docs.forEach((doc) {

      setState(() {
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
      });
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
    invitations = [];

  Query collectionReference2 = FirebaseFirestore.instance
      .collection("Invitations")
      .orderBy('timestamp', descending: true);


  collectionReference2
      .snapshots()
      .listen((data) => data.docs.forEach((doc) {

      setState((){
        invitations.add(
          new Invitation(
              destinataire: doc.get('destinataire'),
              expeditaire: doc.get('expeditaire'),
              vu: doc.get('vu'),
              accepte: doc.get('accepte'),
              refuse: doc.get('refuse'),
              timestamp: doc.get('timestamp'),
              uid: doc.id
          )
      );
      });
    })
  );

    Query collectionReferences = FirebaseFirestore.instance
        .collection("Users").doc(currentFirebaseUser.uid)
        .collection('amis')
        .orderBy('id', descending: true);

    amis = [];

    collectionReferences
        .snapshots()
        .listen((data) { data.docs.forEach((doc) {

      setState(() {
        amis.add(
            new Amis(
              uid: doc.id,
              id: doc.get('id'),
            )
        );
      });
    });
    }
    );


    Query collectionReferenc = FirebaseFirestore.instance
        .collection("Users").doc(currentFirebaseUser.uid)
        .collection('alertes')
        .orderBy('timestamp', descending: true);

    alertes = [];

    collectionReferenc
        .snapshots()
        .listen((data) { data.docs.forEach((doc) {
      setState(() {
        alertes.add(
            new Alerte(
              id: doc.id,
              timestamp: doc.get('timestamp'),
              de: doc.get('de'),
              latitude: doc.get('latitude'),
              longitude: doc.get('longitude'),
              vue: doc.get('vue')
            )
        );
      });
    });
    }
    );
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                height: width(context) / 7,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      'assets/img/logo.png',
                      fit: BoxFit.cover,
                    ),

                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Safety ',
                            style: TextStyle(
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                              fontSize: width(context)/ 15
                            ),
                          ),
                          TextSpan(
                            text: 'Security',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                                fontSize: width(context)/ 15
                            ),
                          ),
                        ],
                      ),
                      textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(width: 15.0),

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
                            Icons.notifications,
                          color: Colors.grey,
                          size: width(context) / 10
                        ),
                      ),
                    ),

                    GestureDetector(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context){
                              return UserProfil();
                            })
                        );
                      },
                      child: CircleAvatar(
                        radius: 30.0,
                        backgroundImage:
                        NetworkImage('${currentUsers.image}'),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: Colors.amber,
              ),
              child: TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context){
                        return Alerter();
                      })
                  );
                },
                child: Text(
                  'LANCER UNE ALERTE',
                  style: TextStyle(
                    fontFamily: 'Roboto',
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    height: 1.0625,
                  ),
                  textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              ),
          ),
            ),

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
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      FontAwesomeIcons.image,
                                      color: Colors.white,
                                      size: width(context) / 15,
                                    ),
                                    Text(
                                      sampleImage == null ?
                                      '  Image' : '   Image ${'ok'}',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(width: 5.0),

                        Divider(),

                        Expanded(
                          child: GestureDetector(
                            onTap: ()=> publierArticle(),
                            child: Container(
                              height: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        'PUBLIER',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                      ),
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

            Container(
              height: 10.0,
              decoration: BoxDecoration(
                color: Colors.grey
              ),
            ),

            SizedBox(height: 10.0),

            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Card(
                child: Column(
                  children: articles.map((item){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: utilisateurs(context, item.id, item),
                            ),
                            SizedBox(height: 0.0),
                            GestureDetector(
                              onTap: (){
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context){
                                      return ItemDetails(comment: false, item: item,);
                                    })
                                );
                              },
                                child: Card(
                                  elevation: 2.0,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: itemArticle(context, _scaffoldKey, item),
                                    ))),
                          ],
                        ),
                      );
                    }).toList(),
                ),
              ),
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