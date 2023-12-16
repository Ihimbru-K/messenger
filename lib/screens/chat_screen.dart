import 'package:flutter/material.dart';
import 'package:messenger/widgets/chat_input_field.dart';
import 'package:messenger/widgets/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  List<String> messages = [
    'Hello',
    'Hi there!',
    'How are you?',
    'I\'m doing great. Thanks!',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        centerTitle: true,
        title: Text(

          'Chat App',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue, // Set your desired app bar background color
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                final isCurrentUserMessage = true;
                return MessageBubble(
                  message: message,
                  isCurrentUserMessage: isCurrentUserMessage,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[200], // Set your desired input field background color
            child: ChatInputField(
              onMessageSent: (message) {
                setState(() {
                  messages.add(message);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}