import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:station_app/admin.dart';
import 'register.dart';
import 'location.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailcontroller = TextEditingController();
  TextEditingController _passwordcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => const AdminPage(title: 'Admin UI')));
          },
          elevation: 0.0,
          child: new Icon(
            Icons.lock,
          ),
          backgroundColor: Color(0x8cc63f),
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
                      SizedBox(
                        height: 130,
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      Form(
                        key: _formKey,
                        child: Column(children: [
                          TextFormField(
                            controller: _emailcontroller,
                            validator: (value) =>
                                EmailValidator.validate(value!)
                                    ? null
                                    : "svp entrez votre email",
                            maxLines: 1,
                            decoration: InputDecoration(
                              hintText: 'Entrez votre email',
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
                            controller: _passwordcontroller,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'svp entrez votre mdp';
                              }
                              return null;
                            },
                            maxLines: 1,
                            obscureText: true,
                            decoration: InputDecoration(
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Entrez votre mot de passe',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                try {
                                  UserCredential userCredential =
                                      await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                              email: _emailcontroller.text,
                                              password:
                                                  _passwordcontroller.text);

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const MyMap(),
                                    ),
                                  );
                                } on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                    print('No user found for that email.');
                                  } else if (e.code == 'wrong-password') {
                                    print(
                                        'Wrong password provided for that user.');
                                  }
                                }
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              padding:
                                  const EdgeInsets.fromLTRB(40, 15, 40, 15),
                              shadowColor: Colors.white,
                              primary: Color.fromARGB(255, 242, 241, 245),
                            ),
                            child: const Text(
                              'Se connecter',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Color.fromARGB(255, 1, 12, 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Pas encore de compte?'),
                              TextButton(
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const RegisterPage(
                                          title: 'Register UI'),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Créer un compte',
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 1, 12, 20),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ]),
                      )
                    ]),
              )
            ])));
  }
}
