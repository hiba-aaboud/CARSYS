import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login.dart';

class adminInt extends StatefulWidget {
  const adminInt({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<adminInt> createState() => _adminIntState();
}

class _adminIntState extends State<adminInt> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _latitude = TextEditingController();
  TextEditingController _longitude = TextEditingController();
  TextEditingController _prix = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(
              "Admin",
              style: TextStyle(color: Colors.white),
            ),
          ]),
          actions: [
            IconButton(
              onPressed: () {
                logout(context);
              },
              icon: Icon(Icons.logout),
            ),
          ],
        ),
        body: Container(
            width: double.infinity,
            child: Stack(alignment: Alignment.center, children: [
              SingleChildScrollView(
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    SizedBox(
                      height: 80,
                    ),
                    Text(
                      "Ajouter une position",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                      ),
                    ),
                    SizedBox(
                      height: 100,
                    ),
                    TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Entrez latitude'),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Entrez longitude'),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                        decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Entrez le prix'),
                    )),
                    SizedBox(
                      height: 50,
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      ),
                      child: const Text(
                        'Ajouter',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ])));
  }

  Future<void> logout(BuildContext context) async {
    CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(title: 'Login UI'),
      ),
    );
  }
}
