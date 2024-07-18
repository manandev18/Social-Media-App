import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/Chatpage.dart';
import 'package:todo/pages/Usertile.dart';
import 'package:todo/pages/loginpage.dart';
import 'package:todo/pages/drawer.dart';
import 'package:todo/pages/profilepage.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final user = FirebaseAuth.instance.currentUser!;

  Stream<List<Map<String, dynamic>>> getUserStream() {
    return FirebaseFirestore.instance
        .collection('user')
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => doc.data())
          .where((userData) => userData['email'] != user.email)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        width: 200,
        backgroundColor: Colors.grey[850],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.house,
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.red,
                  blurRadius: 2,
                ),
              ],
              size: 50,
            ),
            SizedBox(
              height: 40,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Profilepage(context: context)));
              },
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,
                    color: Colors.white,
                    size: 30,
                    shadows: [Shadow(color: Colors.red, blurRadius: 2)],
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Profile',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        shadows: [Shadow(color: Colors.red, blurRadius: 4)]),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      backgroundColor: Color.fromARGB(255, 50, 48, 48),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Contacts',
          style: TextStyle(
              color: Colors.white,
              shadows: [
                Shadow(
                  color: Colors.red,
                  blurRadius: 0.5,
                )
              ],
              fontSize: 25),
        ),
        actions: [
          InkWell(
            onTap: FirebaseAuth.instance.signOut,
            child: Icon(
              Icons.logout,
              shadows: [Shadow(color: Colors.white)],
            ),
          )
        ],
        elevation: 20,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: getUserStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No users found.'));
              }

              final users = snapshot.data!;

              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final userData = users[index];
                  return Column(
                    children: [
                      Builder(builder: (context) {
                        return UserTile(userData: userData);
                      }),
                      SizedBox(height: 8.0),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
