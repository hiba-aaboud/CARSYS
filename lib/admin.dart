// ignore_for_file: unnecessary_new

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:station_app/interfaceadmin.dart';
import 'login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const LoginPage(title: 'Login UI')));
          },
          elevation: 0.0,
          child: new Icon(
            Icons.person,
          ),
          backgroundColor: Color(0x00c4ff),
        ),
        body: Container(
            width: 700.0,
            height: 1100.0,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/login.jpg'),
                  fit: BoxFit.cover),
            ),
            padding: const EdgeInsets.all(20),
            child: Stack(alignment: Alignment.center, children: [
              SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 110,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _email,
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "Please enter a valid email",
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Admin ID',
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            controller: _password,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              }
                              return null;
                            },
                            maxLines: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'mot de passe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 28,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                  login();
                                });
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.fromLTRB(40, 15, 40, 15),
                                primary: Colors.white),
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ])));
  }

  Future<void> login() async {
    FirebaseFirestore.instance.collection("admins").get().then((snapshotData) {
      snapshotData.docs.forEach((element) {
        if (element.get("email") != _email.text) {
          print("id invalide");
        }
        if (element.get("password") != _password.text) {
          print("mdp incorrecte");
        } else {
          // ignore: avoid_print
          print("bonjour");
        }
        setState(() {
          _email.text = "";
          _password.text = "";
        });

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const adminInt(title: 'admin int')));
      });
    });
  }
}
