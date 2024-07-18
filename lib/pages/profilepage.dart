import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/homepage.dart';

class Profilepage extends StatefulWidget {
  BuildContext context;
  Profilepage({required this.context, super.key});

  @override
  State<Profilepage> createState() => _ProfilepageState();
}

class _ProfilepageState extends State<Profilepage> {
  User? user;
  String userName = '';
  String userEmail = '';

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('user')
          .doc(user!.uid)
          .get();

      if (userDoc.exists) {
        setState(() {
          userName = userDoc['name'];
          userEmail = userDoc['email'];
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white, fontSize: 25, shadows: [
            Shadow(
              color: Colors.red,
              blurRadius: 4,
            )
          ]),
        ),
      ),
      backgroundColor: Colors.grey[850],
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Align(
            alignment: Alignment.center,
          ),
          CircleAvatar(
            backgroundColor: Colors.white,
            maxRadius: 60,
            child: Icon(
              Icons.person,
              color: Colors.black,
              size: 50,
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            'Name',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            userName.isNotEmpty ? userName : 'Name not available',
            style:
                TextStyle(color: Colors.blue[100], fontSize: 20, shadows: []),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Email',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          Text(
            userEmail.isNotEmpty ? userEmail : 'Email not available',
            style: TextStyle(color: Colors.blue[100], fontSize: 20),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
