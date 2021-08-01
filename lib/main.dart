
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      home: locationApp(),
    );
  }
}

class locationApp extends StatefulWidget {
  const locationApp({Key? key}) : super(key: key);

  @override
  _locationAppState createState() => _locationAppState();
}

class _locationAppState extends State<locationApp> {

  var locationMessage = "";
  List<Placemark> place = [];
  String _address = ""; // create this variable

  void getCurrentLocation() async {
    var position  = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    var lastposition = await Geolocator.getLastKnownPosition();
    var lat = position.latitude;
    var long = position.longitude;
    print("$lat , $long");


    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    print(placemarks);

    Placemark placeMark  = placemarks[0];
    String? name = placeMark.name;
    String? street = placeMark.street;
    String? subLocality = placeMark.subLocality;
    String? locality = placeMark.locality;
    String? administrativeArea = placeMark.administrativeArea;
    String? postalCode = placeMark.postalCode;
    String? country = placeMark.country;
    String? address = "${name}, ${subLocality}, ${locality}, ${administrativeArea} ${postalCode}, ${country}";




    setState(() {
      locationMessage = "Latitude : $lat , Longitude : $long";
      place = placemarks;
      _address = address;
    });

  }






  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location App by Ameer"),

      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on, size: 46.0, color: Colors.blue,
            ),
            SizedBox(
              height: 10.0,
            ),
            Text(
                "Get Location",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26.0),
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(locationMessage),
            FlatButton(
              onPressed: () {
                getCurrentLocation();
              },
              color: Colors.blue[800],
              child:
              Text("Get Current Location", style: TextStyle(color: Colors.white
              ),
              ),

            ),
            SizedBox(
              height: 20.0,
            ),
            Text(_address)
          ],
        ),
      ),

    );
  }
}
