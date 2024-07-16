import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/registerpage.dart';

Future signup(TextEditingController emailcontroller,
    TextEditingController passwordcontroller, bool ismacth) async {
  if (ismacth) {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    );
  }
}
