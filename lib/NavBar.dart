import 'package:flutter/material.dart';
import 'prixe.dart';
import 'prixg.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(''),
            accountEmail: Text('ORDRE PAR'),
            decoration: BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('images.gasstation.jpg')),
            ),
          ),
          ListTile(
            leading: Icon(Icons.gas_meter),
            title: Text("Prix d'essence"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => prixe(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.gas_meter),
            title: Text("Prix de gasoil"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => prixg(),
                ),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.social_distance),
            title: Text("Distance"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => prixe(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
