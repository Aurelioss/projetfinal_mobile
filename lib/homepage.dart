import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/pages/call_page.dart';
import 'package:projetfinal_mobile/pages/camera_page.dart';
import 'package:projetfinal_mobile/pages/chat_page.dart';
import 'package:projetfinal_mobile/pages/status_page.dart';

const dGreen = Color(0xFF2ac0a6);
const dWhite = Color(0xFFe8f4f2);
const dBlack = Color(0xFF34322f);

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
        elevation: 0,
        backgroundColor: dBlack,
        leading: IconButton(
        onPressed: () {},
    icon: const Icon(
    Icons.menu,
    color: dWhite,
    size: 30,
    ),
    ),
    actions: [
    IconButton(
    onPressed: () {},
    icon: const Icon(
    Icons.search_rounded,
    color: dWhite,
    size: 30,
    ),
    ),
    ],
    ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: dGreen,
        child: const Icon(
          Icons.edit,
          size: 20,
        ),
      ),
      body: Column(
        children: [
          MenuSection(),
          FavoriteSection(),
          Expanded(
            child: MessageSection(),
          )
        ],
      ),

    );}

}


class MenuSection extends StatelessWidget {
  final List menuItems = ["Message", "Online", "Groups", "Calls"];
  MenuSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      color: dBlack,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 15, 15, 25),
          child: Row(
            children: menuItems.map((item) {
              return Container(
                margin: const EdgeInsets.only(right: 55),
                child: Text(
                  item,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class FavoriteSection extends StatelessWidget {
  FavoriteSection({Key? key}) : super(key: key);
  final List favoriteContacts = [
    {
      'name': 'Alla',
      'profile': 'images/avatar/a1.jpg',
    },
    {
      'name': 'Steve',
      'profile': 'images/avatar/a7.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: dBlack,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: const BoxDecoration(
          color: dGreen,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40),
            topLeft: Radius.circular(40),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Favorite contacts",
                    /*style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),*/
                  ),
                ),
                const IconButton(
                  icon: Icon(
                    Icons.more_horiz,
                    color: Colors.white,
                    size: 20,
                  ),
                  onPressed: null,
                ),
              ],
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: favoriteContacts.map((favorite) {
                  return Container(
                    margin: const EdgeInsets.only(left: 15),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(4),
                          height: 70,
                          width: 70,
                          decoration: const BoxDecoration(
                            color: dWhite,
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            radius: 20,
                            backgroundImage: AssetImage(favorite['profile']),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          favorite['name'],
                          /*style: GoogleFonts.inter(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),*/
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MessageSection extends StatelessWidget {
  MessageSection({Key? key}) : super(key: key);
  final List messages = [
    {
      'senderProfile': 'images/avatar/a2.jpg',
      'senderName': 'Lara',
      'message': 'Hello! how are you',
      'unRead': 0,
      'date': '16:35',
    },
    {
      'senderProfile': 'images/avatar/a7.jpg',
      'senderName': 'Stive',
      'message': 'Hello! how are you',
      'unRead': 3,
      'date': '07:31',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: messages.map((message) {
          return InkWell(
            onTap: () {
              /*Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ChatPage(),
                ),
              );*/
            },
            splashColor: dGreen,
            child: Container(
              padding: const EdgeInsets.only(left: 30, right: 10, top: 15),
              child: Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 23),
                    width: 62,
                    height: 62,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(message['senderProfile']),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    message['senderName'],
                                    /*style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),*/
                                  ),
                                  Wrap(children: [
                                    Text(
                                      message['message'],
                                      /*style: GoogleFonts.inter(
                                        color: Colors.black87,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w500,
                                      ),*/
                                    ),
                                  ]),
                                ],
                              ),
                            ),
                            Column(
                              children: [
                                Text(message['date']),
                                message['unRead'] != 0
                                    ? Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: const BoxDecoration(
                                    color: dGreen,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    message['unRead'].toString(),
                                    /*style: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),*/
                                  ),
                                )
                                    : Container(),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Colors.grey[400],
                          height: 0.5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}