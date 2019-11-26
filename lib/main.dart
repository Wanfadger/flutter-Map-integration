import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Sample Map'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GoogleMapController mapController;

  final LatLng _center = const LatLng(45.521563, -122.677433);

  _onMapCreated(GoogleMapController mapController){
    mapController  = mapController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Maps Sample App'),
        backgroundColor: Colors.green[700],
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) => _onMapCreated(mapController),
        initialCameraPosition: CameraPosition(
          target: _center ,
          zoom: 11.0
        ),

      ),
    );
  }

}
