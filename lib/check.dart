import 'package:flutter/material.dart';
import 'package:station_app/bienvenu.dart';
import 'package:station_app/maptap.dart';
import 'interfaceadmin.dart';

class ajoute extends StatefulWidget {
  @override
  State<ajoute> createState() => _ajouteState();
}

class _ajouteState extends State<ajoute> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: 450.0,
            height: 900.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/check.png'),
                  fit: BoxFit.cover),
            ),
            child: Stack(alignment: Alignment.center, children: [
              Column(children: [
                SizedBox(
                  height: 450,
                ),
                Text(
                  "Station Ajouté!",
                  style: TextStyle(
                      color: Color.fromARGB(255, 7, 6, 6),
                      fontSize: 22,
                      fontWeight: FontWeight.w300),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  icon: Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 0, 10, 19),
                    size: 24.0,
                  ),
                  label: Text("Page d'accueil"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => bienvenu(),
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
                  label: Text("Rajouter une station manuellement"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const adminInt(title: 'title'),
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
                  label: Text("Rajouter une station sur map"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => MapTap(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    shadowColor: Colors.white,
                    primary: Color.fromARGB(255, 242, 241, 245),
                  ),
                ),
              ])
            ])));
  }
}
