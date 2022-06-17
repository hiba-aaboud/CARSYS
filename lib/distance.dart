// ignore_for_file: file_names, camel_case_types, avoid_print, empty_catches
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class tabDistance extends StatefulWidget {
  const tabDistance(cont, {Key? key, required String title}) : super(key: key);

  @override
  State<tabDistance> createState() => _tabDistanceState();
}

class _tabDistanceState extends State<tabDistance> {
  List stationslist = [];

  @override
  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic resultat = await getData();
    if (resultat == null) {
      print('error');
    } else {
      setState(() {
        stationslist = resultat;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: const [
          Text(
            "Distance ",
            style: TextStyle(color: Colors.white),
          ),
        ]),
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                stationslist = stationslist.reversed.toList();
              });
            },
            icon: const Icon(Icons.sort),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: stationslist.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(stationslist[index]['nom station']),
              ),
            );
          }),
    );
  }
}

Future getData() async {
  List itemsList = [];
  try {
    await FirebaseFirestore.instance
        .collection('stations')
        .orderBy('locations')
        .get()
        .then((QuerySnapshot querySnapshot) async {
      for (var element in querySnapshot.docs) {
        GeoPoint geoPoint = element.get('locations');
        var lat = geoPoint.latitude;
        var lng = geoPoint.longitude;
        Position currentPosition = await determinePosition();
        var distanceInMeters = Geolocator.distanceBetween(
            lat, lng, currentPosition.latitude, currentPosition.longitude);
        var distanceInKilometres = distanceInMeters * 1000;
        itemsList.add(distanceInKilometres);
      }
    });
  } catch (e) {}
  return itemsList;
}

Future<Position> determinePosition() async {
  Position currentPosition = await Geolocator.getCurrentPosition();
  return currentPosition;
}
