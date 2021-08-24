import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:safetysecurity/Model/Alerte.dart';

import '../globalsVariables.dart';

class MapsView extends StatefulWidget{

  Alerte alerte;
  MapsView({this.alerte});
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MapsView();
  }
}

class _MapsView extends State<MapsView>{

  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex;

  Set<Marker> _Markers = {};

  @override
  void initState() {
    // TODO: implement initState
    _kGooglePlex = CameraPosition(
      target: LatLng(widget.alerte.latitude, widget.alerte.longitude),
      zoom: 14.4746,
    );

    Marker pickupMarker = Marker(
      markerId: MarkerId('pickup'),
      position: LatLng(widget.alerte.latitude, widget.alerte.longitude),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(title: "POSITION", snippet: 'Position d\'alerte'),
    );

    _Markers.add(pickupMarker);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              backButton(context),
            ],
          ),
        ),
        title: Text(
          'SAFETY SECURITY',
          style: TextStyle(
            fontFamily: 'Roboto',
            fontSize: width(context) / 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Container(
        child: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _Markers,
      ),
      ),
    );
  }
}