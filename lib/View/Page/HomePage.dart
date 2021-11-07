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

import 'package:fdottedline/fdottedline.dart';

import 'Alerter.dart';
import 'ArticleItemDetails.dart';
import 'Notifications.dart';
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

  article(){
    articles.clear();

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
  }

  user(){
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
  }

  @override
  void initState() {
    getPosition();

    //article();

    user();

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

  final GlobalKey input = GlobalKey();
  RenderBox box;
  Offset positions;
  double y;
  double x;
  Size size;

  bool visible = false;
  bool time = false;



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      floatingActionButton: floatingAlert(context),
      body: Stack(
        children: [
          
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    height: 56.0,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/img/logo.png',
                          fit: BoxFit.fitHeight,
                          height: 32.0,
                          width: 32.0
                        ),

                        SizedBox(width: 16.0),

                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Safety ',
                                style: TextStyle(
                                  color: couleurNeutre,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 20.0
                                ),
                              ),
                              TextSpan(
                                text: 'Security',
                                style: TextStyle(
                                  color: couleurNeutre,
                                  fontWeight: FontWeight.bold,
                                    fontSize: 20.0
                                ),
                              ),
                            ],
                          ),
                          textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(width: 10.0),

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
                              color: couleurNeutre,
                              size: 20.0
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
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                              NetworkImage('${currentUsers.image}'),
                              backgroundColor: Colors.transparent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left:16.0, right: 16.0),
                  child: Container(
                    height: 36,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: 36.0,
                          width: double.infinity,
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              GestureDetector(
                                onTap: getImage,
                                child: Container(
                                  height: 36.0,
                                  width: 36.0,
                                  child: FDottedLine(
                                    color: sampleImage == null ? couleurNeutre.withOpacity(0.5)
                                    : Colors.red,
                                    height: 36.0,
                                    width: 36.0,
                                    strokeWidth: 1.0,
                                    dottedLength: 4.0,
                                    space: 2.0,
                                    corner: FDottedLineCorner.all(36),
                                    child: Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Image.asset(
                                          'assets/img/icon-image.png',
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    )
                                  ),
                                ),
                              ),

                              SizedBox(width: 16.0),

                              Expanded(
                                key: input,
                                child: GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      box = input.currentContext.findRenderObject() as RenderBox;
                                      positions = box.localToGlobal(Offset.zero); //this is global position
                                      y = positions.dy;
                                      x = positions.dx;
                                      size = box.size;

                                      visible = !visible;
                                    });
                                  },
                                  child: Container(
                                    height: 36.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(36),
                                      border: Border.all(color: couleurNeutre)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Ecrire un article'
                                          ),
                                        ), 

                                        SizedBox(width: 8.0),

                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              time = !time;
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(3.0),
                                            child: Container(
                                              height: 33.0,
                                              width: 33.0,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(33),
                                                color: Colors.black12,
                                              ),
                                              child: Icon(
                                                FontAwesomeIcons.calendar,
                                                size: 16.0,
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ]
                          )
                        ),
                      ],
                    )
                  ),
                ),

                SizedBox(height: 8.0),

                        time ?
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
                        ) : Container(),
                
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    color: couleurPrincipale,
                  ),
                  child: TextButton(
                    onPressed: ()=> publierArticle(),
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

                Container(
                  height: 8.0,
                  decoration: BoxDecoration(
                    color: couleurNeutre.withOpacity(0.5)
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Container(
                    child: Column(
                      children: articles.map((item){
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(
                                  color: couleurNeutre.withOpacity(0.5),
                                ),
                                borderRadius: BorderRadius.circular(10.0)
                              ),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: utilisateurs(context, item.id, item),
                                  ),
                                  GestureDetector(
                                    onTap: (){
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context){
                                            return ItemDetails(comment: false, item: item,);
                                          })
                                      );
                                    },
                                      child: itemArticles(context, _scaffoldKey, item)),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        
          visible ?
          Positioned(
              top: y,
              left: x,
              child: Card(
                elevation: 5.0,
                child: Container(
                  height: 164,
                  width: size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5.0)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: Form(
                        key: formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //Titre
                            Container(
                              width: double.infinity,
                              height: 36.0,
                              child: TextField(
                                focusNode: myTitreFocus,
                                controller: myTitreController,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontSize: width(context) / 25
                                ),
                                decoration: InputDecoration(
                                    labelText: "Titre de l'alerte",
                                    border: new OutlineInputBorder(
                                        borderSide: new BorderSide(
                                          color: const Color(0xff444d5e),
                                        )
                                    )
                                ),
                              ),
                            ),

                            SizedBox(height: 8.0),

                            Container(
                              width: double.infinity,
                              height: 56.0,
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

                            SizedBox(height: 8.0),

                            Container(
                              height: 40.0,
                              width: size.width - 16,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        visible = !visible;
                                      });
                                    },
                                    child: Container(
                                      height: 40.0,
                                      width: (size.width - 32) / 2,
                                      decoration: BoxDecoration(
                                        color: couleurPrimaire.withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Annuler'
                                        ),
                                      )
                                    ),
                                  ),

                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        visible = !visible;
                                      });
                                    },
                                    child: Container(
                                      height: 40.0,
                                      width: (size.width - 32) / 2,
                                      decoration: BoxDecoration(
                                        color: couleurPrimaire,
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Suivant'
                                        ),
                                      )
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                  ),
                ),
              ),

            ) : Container(),
        ],
      ),
    );
  }

  
Widget itemArticles(context, _scaffoldKey, Articles item){
  return Container(
    width: double.infinity,
    height: 300,
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
                showInSnackBar("Vous avez liké", _scaffoldKey, context);
              },
              child: Container(
                width: 45.0,
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
                        '${item.like}',
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
        ),
      ],
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

    setState(() {
      time != time;
    });
  }
}