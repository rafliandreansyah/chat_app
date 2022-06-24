import 'package:flutter/material.dart';

class ChateScreen extends StatelessWidget {
  const ChateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body: Center(
        child: Text('Chat Screen'),
      ),
    );
  }
}
