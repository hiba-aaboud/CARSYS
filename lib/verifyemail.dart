import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:station_app/login.dart';

class verify extends StatefulWidget {
  verify({Key? key}) : super(key: key);

  @override
  State<verify> createState() => _verifyState();
}

class _verifyState extends State<verify> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
      timer = Timer.periodic(
        Duration(seconds: 3),
        (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
    if (isEmailVerified) timer?.cancel();
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 4));
      setState(() => canResendEmail = true);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? LoginPage(title: 'hiba')
      : Scaffold(
          body: Container(
              width: 700.0,
              height: 1100.0,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/check.png'),
                    fit: BoxFit.cover),
              ),
              padding: const EdgeInsets.all(20),
              child: Stack(alignment: Alignment.center, children: [
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  SizedBox(
                    height: 350,
                  ),
                  Text(
                    'Un email de verification est envoyé à: ${FirebaseAuth.instance.currentUser!.email}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      color: Color.fromARGB(255, 1, 12, 20),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.email,
                      color: Color.fromARGB(255, 245, 247, 248),
                      size: 24.0,
                    ),
                    onPressed: canResendEmail ? sendVerificationEmail : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      shadowColor: Color.fromARGB(255, 25, 72, 26),
                      primary: Color.fromARGB(255, 44, 125, 46),
                    ),
                    label: const Text(
                      'Renvoyer l\'email',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton.icon(
                    icon: Icon(
                      Icons.cancel,
                      color: Color.fromARGB(255, 245, 247, 248),
                      size: 24.0,
                    ),
                    onPressed: () {
                      logout(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      shadowColor: Color.fromARGB(255, 121, 17, 17),
                      primary: Color.fromARGB(255, 121, 17, 17),
                    ),
                    label: const Text(
                      'cancel',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ])
              ])));
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
