import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/pages/Chatpage.dart';
import 'package:todo/pages/Usertile.dart';
import 'package:todo/pages/loginpage.dart';

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
                  blurRadius: 6,
                )
              ],
              fontSize: 20),
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
