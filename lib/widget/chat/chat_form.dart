import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatForm extends StatefulWidget {
  const ChatForm({Key? key}) : super(key: key);

  @override
  State<ChatForm> createState() => _ChatFormState();
}

class _ChatFormState extends State<ChatForm> {
  final _chatFormController = TextEditingController();
  var _chatMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    _chatFormController.clear();
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user!.uid)
        .get();
    await FirebaseFirestore.instance.collection('chat').add({
      'text': _chatMessage,
      'createdAt': Timestamp.now(),
      'userId': user.uid,
      'username': userData.data()?['username'] ?? 'No name',
    });
    setState(() {
      _chatMessage = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(labelText: 'Send Message'),
              onChanged: (value) {
                setState(() {
                  _chatMessage = value;
                });
              },
              controller: _chatFormController,
            ),
          ),
          IconButton(
            onPressed: _chatMessage.isEmpty ? null : _sendMessage,
            icon: Icon(
              Icons.send,
              color: _chatMessage.isEmpty
                  ? Colors.grey
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
}
