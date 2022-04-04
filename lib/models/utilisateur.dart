
import 'package:cloud_firestore/cloud_firestore.dart';

class Utilisateur {
  //Attributs
  String id = "";
  String nom = "";
  String mail = "";
  String? profil;
  bool isConnected = false;
  DateTime birthDay = DateTime.now();


  //Contructeur
  Utilisateur(DocumentSnapshot snapshot) {
    id = snapshot.id;
    Map<String, dynamic> map = snapshot.data() as Map<String, dynamic>;
    nom = map["Pseudo"];
    mail = map["Email"];
    profil = map["profilePicture"];
  }

  Utilisateur.vide();

}