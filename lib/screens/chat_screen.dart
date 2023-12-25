import 'package:flutter/material.dart';
import 'package:messenger/widgets/chat_input_field.dart';
import 'package:messenger/widgets/message.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;

  bool isLoading = true;
  List<String> messages = [];

  @override
  void initState() {
    super.initState();
    socket = IO.io('http://localhost:3001', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected to server');
    });

    socket.on('new user', (data) {
      setState(() {
        messages.add(data.toString());
      });
    });

    socket.on('message', (data) {
      setState(() {
        messages.add(data.toString());
        isLoading = false;
      });
    });

    socket.on('disconnect', (_) {
      print('Disconnected from server');
    });

    socket.connect();
  }

  @override
  void dispose() {
    socket.disconnect();
    socket.destroy();
    super.dispose();
  }

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
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: false,
              itemCount: messages.length,
              itemBuilder: (BuildContext context, int index) {
                final message = messages[index];
                final isCurrentUserMessage = false;
                return MessageBubble(
                  message: message,
                  isCurrentUserMessage: isCurrentUserMessage,
                );
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            color: Colors.grey[200],
            child: ChatInputField(
              onMessageSent: (message) {
                setState(() {
                  messages.add(message);
                  socket.emit('message', message);
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}