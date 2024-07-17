import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/registerpage.dart';

Future<UserCredential> signup(
  TextEditingController emailcontroller,
  TextEditingController passwordcontroller,
  TextEditingController namecontroller,
) async {
  try {
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: emailcontroller.text.trim(),
      password: passwordcontroller.text.trim(),
    );
    FirebaseFirestore.instance
        .collection('user')
        .doc(userCredential.user!.uid)
        .set({
      'uid': userCredential.user!.uid,
      'email': userCredential.user!.email,
      'name': namecontroller.text.trim()
    });
    // add user details
    // adduserDetails(namecontroller.text.trim(), emailcontroller.text.trim());

    return userCredential;
  } on FirebaseAuthException catch (e) {
    throw Exception(e.code);
  }
}

Future adduserDetails(String name, String email) async {
  await FirebaseFirestore.instance
      .collection('users')
      .add({'name': name, 'email': email});
}
