import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../widget/chat/message.dart';
import '../widget/chat/chat_form.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _chatSnapshot = FirebaseFirestore.instance
      .collection('chats/auwFUep7zxbKGUAsR0zI/messages')
      .snapshots();
  late FirebaseMessaging _messaging;

  void _handleFirebaseMessaging() async {
    _messaging = FirebaseMessaging.instance;
    String? token = await _messaging.getToken();
    print('Token:  => $token');

    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Setting: => ${settings.authorizationStatus}');
    _messaging.subscribeToTopic('chat');

    FirebaseMessaging.onMessage.listen((event) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${event.data}');

      if (event.notification != null) {
        print('Message also contained a notification: ${event.notification}');
      }
    });
  }

  @override
  void initState() {
    super.initState();

    _handleFirebaseMessaging();
  }

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
          ChatForm(),
        ],
      ),
    );
  }
}
