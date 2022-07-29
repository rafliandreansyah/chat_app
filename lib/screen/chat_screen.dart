import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/chat/message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatSnapshot = FirebaseFirestore.instance
      .collection('chats/auwFUep7zxbKGUAsR0zI/messages')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
              icon: Icon(Icons.more_vert),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.logout,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Message(),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/auwFUep7zxbKGUAsR0zI/messages')
              .add({'text': 'testing'});
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
