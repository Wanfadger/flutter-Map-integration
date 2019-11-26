
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _HomePageState();

}


class _HomePageState extends State<HomePage>{
 Completer<GoogleMapController> mapControllerCompleter = Completer();

  final LatLng _center = const LatLng(40.712776 , -74.005974);
  var zoomLevel = 5.0;


  void _moveToRestaurant({double lat , double lng}) async {
    GoogleMapController controller = await mapControllerCompleter.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat , lng) , tilt: 50.0 , bearing: 45 , zoom: 15) ));
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Flutter Map Demop"),
      ),
      body: Stack(
        children: <Widget>[
          _googleMapWidget() ,
          _scrollWidgetContainer() ,
          _zoomMinus(),
          _zoomPlus(),
        ],
      ),
    );
  }

 Widget _googleMapWidget() {
    return Container(
      width: MediaQuery.of(context).size.width ,
      height: MediaQuery.of(context).size.height,
      child: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (GoogleMapController controller) => mapControllerCompleter.complete(controller),
        initialCameraPosition: CameraPosition(
            target: _center ,
            zoom: 12.0
        ),
        markers: {_marker1() , _marker2()},
      ),
    );
 }

  Marker _marker1() {
    Marker marker = Marker(
      markerId: MarkerId("marker1") ,
      position: LatLng(40.742451 , -74.005959),
      infoWindow: InfoWindow(title: "mark title") ,
      icon: BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueViolet
      )
    );
    return marker;
  }


  Marker _marker2() {
    Marker marker = Marker(
        markerId: MarkerId("marker1") ,
        position: LatLng(40.729640 , -73.983510),
        infoWindow: InfoWindow(title: "mark title") ,
        icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueViolet
        )
    );
    return marker;
  }


  Widget _scrollWidgetContainer() {
    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20.0),
        height: 150.0,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: <Widget>[
            _listViewBoxe(image: "https://homepages.cae.wisc.edu/~ece533/images/mountain.png" , lat:40.742451 , lng:-74.005959 ,
                name: "test name"
            ) ,
            _listViewBoxe(image: "https://homepages.cae.wisc.edu/~ece533/images/mountain.png" , lat:40.742451 , lng:-74.005959 ,
                name: "test name"
            ) ,
            _listViewBoxe(image: "https://homepages.cae.wisc.edu/~ece533/images/mountain.png" , lat:40.742451 , lng:-74.005959 ,
                name: "test name"
            ) ,
          ],
        ),
      ),
    );
  }


  Widget _listViewBoxe({String image , double lat , double lng , String name}){
    return GestureDetector(
      onTap: () => _moveToRestaurant(lat: lat , lng: lng),
      child: Container(
        child: FittedBox(
          child: Material(
            color: Colors.white,
            elevation: 14,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: Color(0X802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 180.0,
                  height: 200.0,
                  child: ClipRect(
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(image , scale: 1.0),
                    ),
                  ),
                ),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: _myDetailsContainer(name: name),
                  ),
                )
              ],
            ),

          ),
        ),
      ),
    );
  }
_myDetailsContainer({String name}){}

Widget _zoomMinus() {
  return Align(
    alignment: Alignment.topLeft,
    child: IconButton(icon: Icon(Icons.code) , onPressed: () => _minusZoom(),),
  );
}

 Widget _zoomPlus() {
   return Align(
     alignment: Alignment.topRight,
     child: IconButton(icon: Icon(Icons.add) , onPressed: () => _plusZoom(),),
   );
 }


 _minusZoom () async {
    setState(() {
      zoomLevel = --zoomLevel;
    });
  GoogleMapController controller = await mapControllerCompleter.future;
  controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.742451 , -74.005959)  , tilt: 50.0 , zoom:  zoomLevel)));
  }

  _plusZoom() async {
    setState(() {
      zoomLevel = ++zoomLevel;
    });
    GoogleMapController controller = await mapControllerCompleter.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(40.742451 , -74.005959)  , tilt: 50.0 , zoom:  zoomLevel)));

  }
}