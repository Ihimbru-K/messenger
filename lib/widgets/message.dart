import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUserMessage;

  const MessageBubble({
    required this.message,
    required this.isCurrentUserMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isCurrentUserMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        padding: EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: isCurrentUserMessage ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          message,
          style: TextStyle(
            color: isCurrentUserMessage ? Colors.white : Colors.black,
          ),
        ),
      ),
    );
  }
}