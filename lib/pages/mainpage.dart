import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/fireservice.dart/auth_page.dart';
import 'package:todo/pages/homepage.dart';
import 'package:todo/pages/loginpage.dart';
import 'package:todo/pages/registerpage.dart';

class Mainpage extends StatelessWidget {
  const Mainpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Homepage();
            } else {
              return AuthPage();
            }
          }),
    );
  }
}
