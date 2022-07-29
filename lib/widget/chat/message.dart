import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Message extends StatelessWidget {
  Message({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _chatStream =
      FirebaseFirestore.instance.collection('chat').snapshots();

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
        return ListView.builder(
          itemCount: message.length,
          itemBuilder: (ctx, index) => Text(
            message[index]['text'],
          ),
        );
      },
    );
  }
}
