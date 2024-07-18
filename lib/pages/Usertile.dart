import 'package:flutter/material.dart';
import 'package:todo/pages/Chatpage.dart';

class UserTile extends StatelessWidget {
  final Map<String, dynamic> userData;

  const UserTile({required this.userData});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.white,
            blurRadius: 2.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Chatpage(
                        receiveremail: userData['name'],
                        receiverid: userData['uid'],
                      )));
        },
        leading: Icon(
          Icons.person,
          color: Colors.white,
          shadows: [Shadow(color: Colors.red, blurRadius: 5)],
        ),
        textColor: Colors.white,
        title: Text(userData['name'] ?? 'No Name'),
        subtitle: Text(userData['email'] ?? 'No Email'),
      ),
    );
  }
}
