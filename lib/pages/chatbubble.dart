import 'package:flutter/material.dart';

class Chatbubble extends StatelessWidget {
  final String message;
  final bool iscurrentuser;
  // BuildContext context;
  Chatbubble(
      {required this.iscurrentuser,
      required this.message,
      // required this.context,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: iscurrentuser ? Colors.black : Color.fromARGB(255, 77, 76, 76),
        borderRadius: BorderRadius.circular(20),
        // boxShadow: [
        //   BoxShadow(color: Colors.deepPurple, blurRadius: 2, spreadRadius: 2)
        // ]),
      ),
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      child: Text(
        message,
        style: TextStyle(color: iscurrentuser ? Colors.white : Colors.white),
      ),
    );
  }
}
