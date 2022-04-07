import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetfinal_mobile/models/message.dart';

class MessageDatabaseService {

  List<Message> _messageListFromSnapshot(QuerySnapshot<Map<String, dynamic>> snapshot) {
    return snapshot.docs.map((doc) {
      return _messageFromSnapshot(doc);
    }).toList();
  }

  Message _messageFromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    var data = snapshot.data();
    if (data == null) throw Exception("message not found");
    return Message.fromMap(data);
  }

  // recupère les message d'un group
  Stream<List<Message>> getMessage(String groupChatId, int limit) {
    return FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .orderBy('timestamp', descending: true)
        .limit(limit)
        .snapshots().map(_messageListFromSnapshot);
  }

  // L'algo qui va envoyé nos message
  void onSendMessage(String groupChatId, Message message) {
    // On créé notre document firebase
    var documentReference = FirebaseFirestore.instance
        .collection('messages')
        .doc(groupChatId)
        .collection(groupChatId)
        .doc(DateTime.now().millisecondsSinceEpoch.toString());

    FirebaseFirestore.instance.runTransaction((transaction) async {
      transaction.set(documentReference,message.toHashMap());
    });
  }
}