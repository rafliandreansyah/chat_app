import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isMe;
  final String username;

  const MessageBubble(this.message, this.isMe, this.username, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          !isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.all(16),
          margin: EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color:
                isMe ? Colors.grey[500] : Theme.of(context).colorScheme.primary,
            borderRadius: BorderRadius.only(
              topLeft: isMe ? Radius.circular(12) : Radius.circular(0),
              topRight: isMe ? Radius.circular(0) : Radius.circular(12),
              bottomLeft: Radius.circular(12),
              bottomRight: Radius.circular(12),
            ),
          ),
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryTextTheme.headline2!.color),
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                message,
                style: TextStyle(
                  color: Theme.of(context).primaryTextTheme.headline2!.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
