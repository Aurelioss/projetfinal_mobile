import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/models/chat_params.dart';
import 'package:projetfinal_mobile/common/loading.dart';
import 'package:projetfinal_mobile/services/message_database.dart';
import 'package:projetfinal_mobile/models/message.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'message_item.dart';

class Chat_Page extends StatefulWidget {

  // chat_Page a besoin de l'uid du chat
  const Chat_Page({Key? key, required this.chatParams}) : super(key: key);
  final ChatParams chatParams;

  @override
  _Chat_PageState createState() => _Chat_PageState(chatParams);
}

const dGreen = Color(0xFF2ac0a6);
const dWhite = Color(0xFFe8f4f2);
const dBlack = Color(0xFF34322f);

class _Chat_PageState extends State<Chat_Page>
    with SingleTickerProviderStateMixin {

//Creates a tabcontroller variable which will be used to hold reference to and cycle //through the our different screens.
//this will be used to detect when to show our FAB
  bool showFab = true;
  bool isCallsPage = false;

  final MessageDatabaseService messageService = MessageDatabaseService();
  _Chat_PageState(this.chatParams);

  final ChatParams chatParams;

  final TextEditingController textEditingController = TextEditingController();
  final ScrollController listScrollController = ScrollController();

  int _nbElement = 20;
  static const int PAGINATION_INCREMENT = 20;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    listScrollController.addListener(_scrollListener);
  }

  _scrollListener() {
    if (listScrollController.offset >= listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _nbElement += PAGINATION_INCREMENT;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            buildListMessage(),
            buildInput()
          ],
        ),
        isLoading ? Loading() : Container()
      ],
    );
  }

  Widget buildListMessage() {
    return Flexible(
      child: StreamBuilder<List<Message>>(
        stream: messageService.getMessage(chatParams.getChatGroupId(), _nbElement),
        builder: (BuildContext context, AsyncSnapshot<List<Message>> snapshot) {
          if (snapshot.hasData) {
            List<Message> listMessage = snapshot.data?? List.from([]);
            return ListView.builder(
              padding: EdgeInsets.all(10.0),
              itemBuilder: (context, index) => MessageItem(
                  message: listMessage[index],
                  userId: chatParams.userUid,
                  isLastMessage: isLastMessage(index, listMessage)
              ),
              itemCount: listMessage.length,
              reverse: true,
              controller: listScrollController,
            );
          } else {
            return Center(child:Loading());
          }
        },
      ),
    );
  }

  bool isLastMessage(int index, List<Message> listMessage) {
    if (index == 0) return true;
    if (listMessage[index].idFrom != listMessage[index - 1].idFrom) return true;
    return false;
  }

  // Textfield ou l'on va écrire notre message avant de l'envoyer
  Widget buildInput() {
    return Container(
      width: double.infinity,
      height: 50.0,
      decoration: BoxDecoration(border: Border(top: BorderSide(color: Colors.black, width: 0.5)), color: Colors.white),
      child: Row(
        children: [
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              child: IconButton(
                icon: Icon(Icons.image),
                onPressed: getImage,
                color: Colors.blueGrey,
              ),
            ),
            color: Colors.white,
          ),
          Flexible(
            child: TextField(
              onSubmitted: (value) {
                onSendMessage(textEditingController.text, 0);
              },
              style: TextStyle(color: Colors.blueGrey, fontSize: 15.0),
              controller: textEditingController,
              decoration: InputDecoration.collapsed(
                hintText: 'Your message...',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
          // Button send message
          Material(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8.0),
              child: IconButton(
                icon: Icon(Icons.send),
                onPressed: () => onSendMessage(textEditingController.text, 0),
                color: Colors.blueGrey,
              ),
            ),
            color: Colors.white,
          ),
        ],
      ),
    );
  }

  Future getImage() async {
    // TODO get and send image
  }

  void onSendMessage(String content, int type) {
    if (content.trim() != '') {
      messageService.onSendMessage(
          chatParams.getChatGroupId(),
          Message(
              idFrom: chatParams.userUid,
              idTo: chatParams.peer.uid,
              timestamp: DateTime.now().millisecondsSinceEpoch.toString(),
              content: content,
              type: type));
      listScrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.easeOut);
      textEditingController.clear();
    } else {
      Fluttertoast.showToast(
          msg: 'Nothing to send', backgroundColor: Colors.red, textColor: Colors.white);
    }
  }
}
/*
class BottomSection extends StatelessWidget {
  const BottomSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10.0,
      color: dWhite,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                height: 43,
                decoration: const BoxDecoration(
                  color: dGreen,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Row(
                  children: const [
                    SizedBox(width: 10.0),
                    Icon(
                      Icons.insert_emoticon,
                      size: 25.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.upload_outlined,
                      size: 25.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 8.0,
                    ),
                    Icon(
                      Icons.image,
                      size: 25.0,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10.0,
                    ),
                  ],
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 25,
              ),
              width: 45,
              height: 45,
              decoration: const BoxDecoration(
                color: dGreen,
                shape: BoxShape.circle,
              ),
              child: const IconButton(
                icon: Icon(
                  Icons.mic_none_sharp,
                  color: Colors.white,
                ),
                onPressed: null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
*/


/*
class ChatingSection extends StatelessWidget {
  final String senderProfile = 'images/avatar/a3.jpg';
  final String receiverProfile = 'images/avatar/a6.jpg';
  const ChatingSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      height: double.infinity,
      decoration: const BoxDecoration(
        color: dWhite,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          topLeft: Radius.circular(40),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            TextMessage(
              message: "Une Game ce soir ?",
              date: "17:19",
              senderProfile: senderProfile,
              isReceiver: 1,
              isDirect: 0,
            ),
            TextMessage(
              message: "Pas possible",
              date: "17:13",
              senderProfile: senderProfile,
              isReceiver: 0,
              isDirect: 0,
            ),
            TextMessage(
              message: "J'ai un DS de maths-Physique demain",
              date: "17:10",
              senderProfile: senderProfile,
              isReceiver: 0,
              isDirect: 1,
            ),
            TextMessage(
              message: "pouaaaaa",
              date: "17:10",
              senderProfile: senderProfile,
              isReceiver: 1,
              isDirect: 0,
            ),
            const ImageMessage(
              image: 'assets/login.png',
              date: "17:09",
              description: "May the force be with",
            ),
            AudioMessage(date: "18:05", senderProfile: senderProfile),
            TextMessage(
              message: "Alors ce pti DS ?",
              date: "12:59",
              senderProfile: senderProfile,
              isReceiver: 1,
              isDirect: 0,
            ),
            TextMessage(
              message: "Comme d'hab",
              date: "14:53",
              senderProfile: senderProfile,
              isReceiver: 0,
              isDirect: 0,
            ),
            TextMessage(
              message: "Si j'ai 5/20 chui un crack",
              date: "14:53",
              senderProfile: senderProfile,
              isReceiver: 0,
              isDirect: 1,
            ),
            TextMessage(
              message: "ça a l'air fun la prépas",
              date: "16:48",
              senderProfile: senderProfile,
              isReceiver: 1,
              isDirect: 0,
            ),
            const SizedBox(height: 15),
          ],
        ),
      ),
    );
  }
}
*/

class TextMessage extends StatelessWidget {
  final String message, date, senderProfile;
  final int isReceiver, isDirect;

  const TextMessage({
    Key? key,
    required this.message,
    required this.date,
    required this.senderProfile,
    required this.isReceiver,
    required this.isDirect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          isReceiver == 1 && isDirect == 0
              ? Container(
            margin: const EdgeInsets.only(right: 15),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(senderProfile),
                fit: BoxFit.cover,
              ),
            ),
          )
              : SizedBox(
            width: 60,
            child: Row(
              children: [
                const Icon(
                  Icons.check,
                  color: dGreen,
                  size: 13.0,
                ),
                const SizedBox(width: 7.0),
                Text(
                  date,
                  /*style: GoogleFonts.inter(
                    color: dGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),*/
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.centerLeft,
              margin: isReceiver == 1
                  ? const EdgeInsets.only(
                right: 25,
              )
                  : const EdgeInsets.only(
                left: 20,
              ),
              padding: const EdgeInsets.all(6),
              height: 55,
              decoration: isReceiver == 1
                  ? const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              )
                  : const BoxDecoration(
                color: dGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                ),
              ),
              child: Text(
                message,
                /*style: GoogleFonts.inter(
                  color: isReceiver == 1 ? dGreen : Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),*/
              ),
            ),
          ),
          isReceiver == 1 && isDirect == 0
              ? SizedBox(
            width: 60,
            child: Row(
              children: [
                const Icon(
                  Icons.check,
                  color: dGreen,
                  size: 13.0,
                ),
                const SizedBox(
                  width: 7.0,
                ),
                Text(
                  date,
                  /*style: GoogleFonts.inter(
                    color: dGreen,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),*/
                ),
              ],
            ),
          )
              : Container(),
          isDirect == 0 && isReceiver == 0
              ? Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 10,
            ),
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(senderProfile),
                fit: BoxFit.cover,
              ),
            ),
          )
              : Container(),
          isReceiver == 0 && isDirect == 1
              ? Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 10,
            ),
            width: 45,
            height: 45,
          )
              : Container(),
        ],
      ),
    );
  }
}

class AudioMessage extends StatelessWidget {
  final String date, senderProfile;

  const AudioMessage({
    Key? key,
    required this.date,
    required this.senderProfile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: Row(
            children: [
              Text(
                "17:14",
                /*style: GoogleFonts.inter(
                  color: dGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),*/
              ),
              const SizedBox(width: 7.0),
              const Icon(
                Icons.check,
                color: dGreen,
                size: 13.0,
              ),
            ],
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.only(
              left: 15,
              bottom: 5,
            ),
            padding: const EdgeInsets.all(6),
            height: 55,
            decoration: const BoxDecoration(
              color: dGreen,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Row(
              children: [
                const IconButton(
                  icon: Icon(
                    Icons.play_circle_outline,
                    color: Colors.white,
                  ),
                  onPressed: null,
                ),
                Image.asset(
                  'images/sound-waves.png',
                  height: 35,
                  width: 130,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 10,
          ),
          width: 45,
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(senderProfile),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageMessage extends StatelessWidget {
  final String image, date, description;

  const ImageMessage({
    Key? key,
    required this.image,
    required this.date,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: 16,
          ),
          width: 45,
          height: 45,
        ),
        Expanded(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  right: 26,
                  top: 5,
                ),
                height: 150,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(22.0),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  top: 8,
                  right: 25,
                  bottom: 10,
                ),
                padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
                height: 55,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
                child: Wrap(children: [
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    /*style: GoogleFonts.inter(
                      color: dGreen,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),*/
                  ),
                ]),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 60,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Icon(
                Icons.check,
                color: dGreen,
                size: 13.0,
              ),
              const SizedBox(width: 7.0),
              Text(
                "17:14",
                /*style: GoogleFonts.inter(
                  color: dGreen,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),*/
              ),
            ],
          ),
        )
      ],
    );
  }
}

