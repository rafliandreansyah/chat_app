import 'package:chat_app/widget/chat/message_bubble.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Message extends StatelessWidget {
  Message({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _chatStream = FirebaseFirestore.instance
      .collection('chat')
      .orderBy('createdAt', descending: true)
      .snapshots();
  final userId = FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _chatStream,
      builder: (ctx, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text('Something went wrong'),
          );
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        var message = snapshot.data!.docs;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            reverse: true,
            itemCount: message.length,
            itemBuilder: (ctx, index) => MessageBubble(
              message[index]['text'],
              message[index]['userId'] == userId,
              message[index]['username'],
              key: ValueKey(message[index].id),
            ),
          ),
        );
      },
    );
  }
}
