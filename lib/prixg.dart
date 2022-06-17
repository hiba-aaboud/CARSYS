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
          backgroundColor: Color.fromARGB(255, 2, 35, 84),
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
          color: Color.fromARGB(255, 249, 249, 250),
          child: ListView.builder(
              itemCount: stationslist.length,
              itemBuilder: (context, index) {
                return Container(
                    padding: EdgeInsets.all(5.0),
                    child: Material(
                        elevation: 4.0,
                        borderRadius: BorderRadius.circular(5.0),
                        color: index % 2 == 0
                            ? Color.fromARGB(255, 55, 64, 194)
                            : Color.fromARGB(255, 34, 174, 255),
                        child: ListTile(
                          title: Text(
                            stationslist[index]['nom station'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Text(stationslist[index]['adresse'],
                              style: TextStyle(
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              )),
                          trailing:
                              Text('${stationslist[index]['prix gasoil']} Dhs',
                                  style: TextStyle(
                                    fontStyle: FontStyle.italic,
                                    fontSize: 15,
                                  )),
                        )));
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
