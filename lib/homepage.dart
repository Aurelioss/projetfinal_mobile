import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/pages/chat/chat_page.dart';
import 'pages/chat/chat_page.dart';


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
      appBar: AppBar( //App bar at top
        elevation: 0,
        backgroundColor: dBlack,

        leading: IconButton( //menu button in app bar
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            color: Colors.white,
            size: 30,
          ),
        ),
        actions: [
          IconButton( //bouton recherche
            onPressed: () {},
            icon: const Icon(
              Icons.search_rounded,
              color: Colors.white,
              size: 30,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton( //boutton pour écrire nouveau message
        onPressed: () {},
        backgroundColor: Colors.black,
        child: const Icon(
          Icons.edit,
          size: 20,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: MessageSection(),
          )
        ],
      ),

    );
  }
}

class MessageSection extends StatelessWidget {
  MessageSection({Key? key}) : super(key: key);

  final Stream<QuerySnapshot> _usersStream =
  FirebaseFirestore.instance.collection('Users').snapshots();


  @override
  Widget build(BuildContext context) {

    // stream builder pour récup les données de tout les users
    // et boucler pour chaque user
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading");
          }


          return SingleChildScrollView(
            child: Column(
              children: snapshot.data!.docs.map((DocumentSnapshot document) {

                // on recup la snapshot (les infos des users) et on boucle dessus
                // j'ai l'impression que le .toList() a la fin fait la boucle
                Map<String, dynamic> data = document.data()! as Map<
                    String,
                    dynamic>;
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        // faut changer chat_page pour qu'il accepte en argument
                        // l'uid de la conv sur laquelle on a cliqué
                        /*
                        faut aussi créé une collection 'conversation' dans firebase
                        on changera l'ui de la conversation celon le nombre de personne dans la discussion
                        genre https://www.youtube.com/watch?v=fapqK4NqTOc vers 9:34
                         */
                        builder: (context) => Chat_Page(),
                      ),
                    );
                  },
                  splashColor: Colors.blue,
                  child: Container(
                    padding: const EdgeInsets.only(
                        left: 30, right: 10, top: 15),
                    child: Row(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 23),
                          width: 62,
                          height: 62,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.green,
                            image: DecorationImage(
                              image: AssetImage(/*data['Profile']*/'lib/assets/login.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(top: 25),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment
                                          .start,
                                      mainAxisAlignment: MainAxisAlignment
                                          .center,
                                      children: [
                                        Text(
                                          data['Pseudo'],
                                          /*style: GoogleFonts.inter(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                    ),*/
                                        ),
                                        Wrap(children: [
                                          Text(
                                            //data['LastMessage'],
                                            'Hello! how are you',
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
                                      Text(/*message['date']*/
                                          'lastMessage date toString'),
                                      /*message['unRead']*/ 1 != 0
                                          ? Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: dGreen,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          /*message['unRead'].toString()*/
                                          'unread messageNbr',
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
        });
  }
}