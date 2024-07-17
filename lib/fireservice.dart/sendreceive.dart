import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo/models/message.dart';

Future<void> sendMessages(String receiverid, message) async {
  final String currentuserid = FirebaseAuth.instance.currentUser!.uid;
  final String? currentuseremail = FirebaseAuth.instance.currentUser!.email;
  final Timestamp timestamp = Timestamp.now();

  // creating a new message
  Message newmessage = Message(
      senderid: currentuserid,
      senderemail: currentuseremail!,
      receiverid: receiverid,
      message: message,
      timestamp: timestamp);

  // creating chat room
  List<String> ids = [currentuserid, receiverid];
  ids.sort();
  String chatroomid = ids.join('_');
  await FirebaseFirestore.instance
      .collection("chatrooms")
      .doc(chatroomid)
      .collection("messages")
      .add(newmessage.toMap());
}

Stream<QuerySnapshot> getmessage(String userid, otheruserid) {
  List<String> ids = [userid, otheruserid];
  ids.sort();
  String chatroomid = ids.join('_');
  return FirebaseFirestore.instance
      .collection('chatrooms')
      .doc(chatroomid)
      .collection('messages')
      .orderBy('timestamp', descending: false)
      .snapshots();
}
