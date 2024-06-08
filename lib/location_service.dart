import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationService extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<LocationService> {
  double latitude = 0.0;
  double longitude = 0.0;

  Future<void> getCoordinates() async {
    var locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      setState(() {
        latitude = position.latitude;
        longitude = position.longitude;
      });
    } else {
      // Handle permission denied scenario (e.g., show a dialog)
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Latitude: $latitude'),
              Text('Longitude: $longitude'),
              ElevatedButton(
                onPressed: getCoordinates,
                child: Text('Get Location'),
              ),
            ],
          ),
        ),
      );
    
  }
}
