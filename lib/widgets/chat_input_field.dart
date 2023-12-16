import 'package:flutter/material.dart';

//Chat input field where we write in messages
class ChatInputField extends StatefulWidget {
  final ValueChanged<String> onMessageSent;

  const ChatInputField({
    required this.onMessageSent,
  });

  @override
  _ChatInputFieldState createState() => _ChatInputFieldState();
}

class _ChatInputFieldState extends State<ChatInputField> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Type a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () {
              //ThE message should be the text of the message controller
              final message = _textEditingController.text;
              widget.onMessageSent(message);
              _textEditingController.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}