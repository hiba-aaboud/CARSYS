import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:station_app/affichage.dart';
import 'package:station_app/mapadmin.dart';
import 'location.dart';
import 'login.dart';
import 'interfaceadmin.dart';
import 'maptap.dart';

class bienvenu extends StatefulWidget {
  bienvenu({Key? key}) : super(key: key);

  @override
  State<bienvenu> createState() => _bienvenuState();
}

class _bienvenuState extends State<bienvenu> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 2, 35, 84),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Home",
              style: TextStyle(color: Color.fromARGB(255, 244, 244, 245)),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => mapAdmin(),
                ),
              );
            },
            icon: const Icon(Icons.map),
          ),
        ],
      ),
      body: Container(
        width: 450.0,
        height: 740.0,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/interface.jpg'),
              fit: BoxFit.cover),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: size.height * 0.15,
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Color.fromARGB(255, 55, 50, 117),
                    radius: 40,
                    child: Image.asset('assets/images/avatar.jpg'),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Bonjour Maroua AABOUD!",
                    style: TextStyle(
                        color: Color.fromARGB(255, 254, 253, 253),
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                  ),
                  Form(
                      child: Column(children: [
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.gas_meter,
                        color: Color.fromARGB(255, 0, 10, 19),
                        size: 24.0,
                      ),
                      label: Text('Afficher les stations'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => affichage(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                        shadowColor: Colors.white,
                        primary: Color.fromARGB(255, 242, 241, 245),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 0, 10, 19),
                        size: 24.0,
                      ),
                      label: Text('Ajouter une Station manuellement'),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) =>
                                const adminInt(title: 'title'),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                        shadowColor: Colors.white,
                        primary: Color.fromARGB(255, 242, 241, 245),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.add,
                        color: Color.fromARGB(255, 0, 10, 19),
                        size: 24.0,
                      ),
                      label: Text('  Ajouter une Station sur la carte   '),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const MapTap(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                        shadowColor: Colors.white,
                        primary: Color.fromARGB(255, 242, 241, 245),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton.icon(
                      icon: Icon(
                        Icons.logout,
                        color: Color.fromARGB(255, 0, 10, 19),
                        size: 24.0,
                      ),
                      label: Text('   Se déconnecter   '),
                      onPressed: () {
                        logout(context);
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                        shadowColor: Colors.white,
                        primary: Color.fromARGB(255, 242, 241, 245),
                      ),
                    ),
                  ]))
                ],
              ),
            ),
          ],
        ),
      ),
    );
    // ignore: dead_code
  }

  Future<void> logout(BuildContext context) async {
    const CircularProgressIndicator();
    await FirebaseAuth.instance.signOut();

    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => const LoginPage(title: 'admin UI'),
      ),
    );
  }
}
