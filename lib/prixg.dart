import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class prixg extends StatefulWidget {
  prixg({Key? key}) : super(key: key);

  @override
  State<prixg> createState() => _prixgState();
}

class _prixgState extends State<prixg> {
  List stationslist = [];

  void initState() {
    super.initState();
    fetchDatabaseList();
  }

  fetchDatabaseList() async {
    dynamic res = await getData();
    if (res == null) {
      print('error');
    } else {
      setState(() {
        stationslist = res;
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
              "Prix gasoil",
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
        body: Container(
          child: ListView.builder(
              itemCount: stationslist.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(stationslist[index]['nom station']),
                    trailing: Text('${stationslist[index]['prix gasoil']} Dhs'),
                  ),
                );
              }),
        ));
  }

  Future getData() async {
    List itemsList = [];
    try {
      await FirebaseFirestore.instance
          .collection('stations')
          .orderBy('prix gasoil')
          .get()
          .then((QuerySnapshot querySnapshot) {
        querySnapshot.docs.forEach((element) {
          itemsList.add(element.data());
        });
      });
      return itemsList;
    } catch (e) {}
  }
}
