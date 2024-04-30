import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:messenger_x/components/chatbubble.dart';
import 'package:messenger_x/components/textfield.dart';
import 'package:messenger_x/models/message.dart';
import 'package:messenger_x/models/user.dart';
import 'package:messenger_x/services/auth/auth_service.dart';
import 'package:messenger_x/services/chat/chat_service.dart';

class Chat extends StatelessWidget {
  final UserModel receiver;
  Chat({super.key, required this.receiver});

  final TextEditingController messageController = TextEditingController();

  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  //send message function
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await _chatService.sendMessage(receiver.uid, messageController.text);
    }

    messageController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          receiver.name,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          //display all messages
          Expanded(child: _buildMessageList()),
          //user input
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildMessageList() {
    String senderId = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(receiver.uid, senderId),
        builder: (context, snapshot) {
//errors
          if (snapshot.hasError) {
            return const Text('Error');
          }

//loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text('loading....');
          }

//message list

          return ListView(
            children: snapshot.data!.docs
                .map((doc) => _buildMessageItem(doc))
                .toList(),
          );
        });
  }

  Widget _buildMessageItem(DocumentSnapshot doc) {
    Message message = Message.fromMap(doc.data() as Map<String, dynamic>);

    //isCurrentUser
    bool isCurrentUser = message.senderID == _authService.getCurrentUser()!.uid;

    return Container(
      padding: const EdgeInsets.only(top: 2),
      //alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(message: message.message, isCurrentUser: isCurrentUser),
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Expanded(
              child: TextFieldX(
                  hintText: 'type message',
                  obscureText: false,
                  controller: messageController)),
          Container(
            margin: const EdgeInsets.only(right: 25),
            child: IconButton(
                onPressed: () {
                  sendMessage();
                },
                icon: Icon(
                  Icons.send,
                  size: 30,
                  color: Colors.blue.shade900,
                )),
          )
        ],
      ),
    );
  }
}
