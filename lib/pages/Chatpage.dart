import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo/fireservice.dart/sendreceive.dart';
import 'package:todo/models/message.dart';
import 'package:todo/pages/chatbubble.dart';

class Chatpage extends StatelessWidget {
  final String receiveremail;
  final String receiverid;

  Chatpage({super.key, required this.receiveremail, required this.receiverid});
  final TextEditingController _messagecontroller = TextEditingController();

  void sendmessage() async {
    if (_messagecontroller.text.isNotEmpty) {
      await sendMessages(receiverid, _messagecontroller.text.trim());
      _messagecontroller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 50, 48, 48),
      appBar: AppBar(
        leading: Icon(
          Icons.chat,
          shadows: [Shadow(color: Colors.red, blurRadius: 10)],
        ),
        title: Text(
          receiveremail,
          style: TextStyle(
              shadows: [Shadow(color: Colors.red)],
              fontSize: 14,
              color: Colors.white,
              letterSpacing: 0.5),
        ),
        centerTitle: true,
        backgroundColor: Colors.black87,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 10)),
          // display messages
          Expanded(child: _buildermessagelist()),
          // user input
          _builduserinput(),
        ],
      ),
    );
  }

  // build message list
  Widget _buildermessagelist() {
    String senderid = FirebaseAuth.instance.currentUser!.uid;
    return StreamBuilder(
        stream: getmessage(senderid, receiverid),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error'));
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Loading'));
          }
          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildemessaageitem(doc))
                .toList(),
          );
        });
  }

  Widget _buildemessaageitem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool iscurrentuser =
        data['senderid'] == FirebaseAuth.instance.currentUser!.uid;
    var alignment =
        iscurrentuser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      child: Column(
        crossAxisAlignment:
            iscurrentuser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Chatbubble(iscurrentuser: iscurrentuser, message: data['message'])
        ],
      ),
    );
  }

  Widget _builduserinput() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 10.0),
      color: Color.fromARGB(255, 50, 48, 48),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 139, 142, 199),
                    spreadRadius: 2,
                    blurRadius: 2,
                  )
                ],
              ),
              child: TextField(
                controller: _messagecontroller,
                decoration: InputDecoration(
                  fillColor: const Color.fromARGB(255, 0, 0, 0),
                  // focusColor: Colors.black,
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 10.0),
                  hintText: 'Type a message',
                  hintStyle: TextStyle(color: Color.fromARGB(255, 71, 71, 71)),
                ),
              ),
            ),
          ),
          SizedBox(width: 8.0),
          GestureDetector(
            onTap: sendmessage,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[850],
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.red,
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Icon(
                Icons.send,
                color: Colors.white,
                shadows: [Shadow(color: Colors.red, blurRadius: 6)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
