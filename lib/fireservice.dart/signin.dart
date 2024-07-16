import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/loginpage.dart';

Future signin(TextEditingController emailcontroller,
    TextEditingController passwordcontroller) async {
  await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim());
}
