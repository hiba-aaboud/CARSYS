// ignore_for_file: non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MyMap extends StatefulWidget {
  const MyMap({Key? key}) : super(key: key);
  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {
  Set<Marker> positions = <Marker>{};

  Set<Polyline> polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  late PolylinePoints polylinePoints;

  @override
  void initState() {
    super.initState();
    polylinePoints = PolylinePoints();
    setInitialLocation();
  }

  late LatLng currentPosition;
  late LatLng destloc;

  LatLng destination = const LatLng(33.97517863904228, -6.885252188125281);

  Future<void> setInitialLocation() async {
    Position userPosition = await determinePosition();
    currentPosition = LatLng(userPosition.latitude, userPosition.longitude);

    destloc = LatLng(destination.latitude, destination.longitude);
  }

  Set<Circle> cercles = {
    Circle(
      circleId: const CircleId('1'),
      center: const LatLng(33.971588, -6.849813),
      radius: 300,
      fillColor: Colors.blue.shade100.withOpacity(0.6),
      strokeColor: Colors.blue.shade100.withOpacity(0.3),
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Google Maps'), // Titre app
      ),
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          compassEnabled: true,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          initialCameraPosition: const CameraPosition(
            target: LatLng(33.971588, -6.849813),
            zoom: 14.4746,
          ),
          onMapCreated: (GoogleMapController controller) {
            setPolylines();
            setState(() async {
              positions.add(
                const Marker(
                  markerId: MarkerId('1'),
                  position: LatLng(33.971588, -6.849813), // Position du marker
                  infoWindow: InfoWindow(
                    title: '14.38 dhs',
                    snippet: 'Station SetupSys',
                  ),
                ),
              );

              positions.add(Marker(
                markerId: const MarkerId('sourcePin'),
                position: currentPosition,
                icon: BitmapDescriptor.defaultMarker,
              ));

              BitmapDescriptor gas = await BitmapDescriptor.fromAssetImage(
                const ImageConfiguration(),
                "images/gasstation.jpg",
              );

              positions.add(Marker(
                markerId: const MarkerId('destinationPin'),
                position: destination,
                icon: gas,
              ));
            });
          },
          markers: positions,
          circles: cercles,
          polylines: polylines,
        ),
      ]),
    );
  } // Widget

  void setPolylines() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        "AIzaSyBMbtqTNFieUhAsur29bfL51bRtNJWmb7c",
        PointLatLng(currentPosition.latitude, currentPosition.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.status == 'OK') {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }

      setState(() {
        polylines.add(Polyline(
            width: 10,
            polylineId: const PolylineId('route'),
            color: const Color(0xFF08A5CB),
            points: polylineCoordinates));
      });
    }
  }
}

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return Future.error('Location services are disabled'); // Service disabled
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error("Location permission denied"); // Permission denied
    }
  }
  if (permission == LocationPermission.deniedForever) {
    return Future.error('Location permissions are permanently denied');
  }
  Position userPosition = await Geolocator.getCurrentPosition();
  return userPosition;
}
