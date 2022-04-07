import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/models/chat_params.dart';

import 'chat_page.dart';

class ChatScreen extends StatelessWidget {
  final ChatParams chatParams;

  const ChatScreen({Key? key, required this.chatParams}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          title: Text('Chat with ' + chatParams.peer.name)
      ),
      body: Chat_Page(chatParams: chatParams),
    );*/

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: dBlack,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: 23,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
            'Friend name'
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.more_vert,
              color: Colors.white,
              size: 23,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Chat_Page(chatParams: chatParams),
    );
  }
}