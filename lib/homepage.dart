import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/pages/call_page.dart';
import 'package:projetfinal_mobile/pages/camera_page.dart';
import 'package:projetfinal_mobile/pages/chat_page.dart';
import 'package:projetfinal_mobile/pages/status_page.dart';

class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {

//Creates a tabcontroller variable which will be used to hold reference to and cycle //through the our different screens.
//this will be used to detect when to show our FAB
  bool showFab = true;
  bool isCallsPage = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        elevation: 0.7,
        bottom: TabBar(
          indicatorColor: Colors.white,
          tabs: <Widget>[
            Tab(icon: Icon(Icons.camera_alt)),
            Tab(text: "CHATS"),
            Tab(
              text: "STATUS",
            ),
            Tab(
              text: "CALLS",
            ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(
        children: <Widget>[
        ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: isCallsPage? Icon(
          Icons.add_call,
          color: Colors.white,
        ):Icon(
          Icons.message,
          color: Colors.white,
        ),
        onPressed: () => print("fab clicked"),
      )
          : null,
    );
  }
}