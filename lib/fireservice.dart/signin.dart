import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/loginpage.dart';

Future<UserCredential> signin(TextEditingController emailcontroller,
    TextEditingController passwordcontroller, BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailcontroller.text.trim(),
            password: passwordcontroller.text.trim());
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Login successfull')));

    return userCredential;
  } on FirebaseAuthException catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Email or password is incorrect')));
    throw Exception(e);
  }
}
