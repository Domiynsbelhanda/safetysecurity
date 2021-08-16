import 'package:flutter/material.dart';

import '../../globalsVariables.dart';

class AddPlace extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _AddPlace();
  }
}

class _AddPlace extends State<AddPlace>{

  final FocusNode myDenominationFocus = FocusNode();
  final FocusNode myDescriptionFocus = FocusNode();

  TextEditingController myDenominationController = TextEditingController();
  TextEditingController myDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  backButton(context),

                  SizedBox(width: 15.0),

                  Text(
                    'SAFETY SECURITY',
                    style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: width(context) / 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),


              SizedBox(height: 20.0),

              Text(
                'AJOUT D\'UN LIEU',
                style: TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: width(context) / 15,
                ),
                textHeightBehavior: TextHeightBehavior(applyHeightToFirstAscent: false),
              ),

              SizedBox(height: 10.0),

              Container(
                width: double.infinity,
                height: width(context) / 12.5,
                child: TextField(
                  focusNode: myDenominationFocus,
                  controller: myDenominationController,
                  keyboardType: TextInputType.text,
                  style: TextStyle(
                      fontSize: width(context) / 25
                  ),
                  decoration: InputDecoration(
                      labelText: "Denomination |",
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

              SizedBox(height: 5.0),

              TextButton(
                onPressed: (){
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlacePicker(
                        apiKey: apiKey,   // Put YOUR OWN KEY here.
                        onPlacePicked: (result) {
                          selectedPlace = result;
                          print(result.address);
                          Navigator.of(context).pop();
                        },
                        initialPosition: kInitialPosition,
                        useCurrentLocation: true,
                      ),
                    ),
                  );*/
                },
                child: Text(
                  'Choix du lieu sur la carte'
                ),
              ),

              //selectedPlace == null ? Container() : Text(selectedPlace.formattedAddress ?? ""),
            ],
          ),
        ),
      ),
    );
  }
}