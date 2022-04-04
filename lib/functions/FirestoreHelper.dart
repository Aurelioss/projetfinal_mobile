import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:projetfinal_mobile/models/utilisateur.dart';

class FirestoreHelper {
  //Attributs
  final auth = FirebaseAuth.instance;
  final fire_user = FirebaseFirestore.instance.collection("Users");
  final fireStorage = FirebaseStorage.instance;



  //Constructeur



  //méthode

//Pour l'inscription
  Future Inscription(String mail,String password,String username) async {
    UserCredential resultat = await auth.createUserWithEmailAndPassword(email: mail, password: password);
    User? user = resultat.user;
    String uid = user!.uid;
    Map<String,dynamic>map = {
      "Pseudo": username,
      "Email": mail,
      "Password":password

    };
    addUser(uid, map);

  }



//Pour la connexion

  Future Connexion(String mail, String password) async {
    UserCredential resultat = await auth.signInWithEmailAndPassword(email: mail, password: password);

  }


//Ajouter des utilisateurs
  addUser(String uid,Map<String,dynamic>map){
    FirebaseFirestore.instance.collection('Users')
        .add({'Email' : map['Email'], 'Password' : map['Password'], 'Pseudo' : map['Pseudo']});
    //fire_user.doc(uid).set(map);

  }


//Modifier les informations d'un utilisateur
  updatedUser(String uid,Map<String,dynamic>map){
    fire_user.doc(uid).update(map);
  }

  Future <String> getIdentifiant() async{
    String uid = auth.currentUser!.uid;
    return uid;
  }

  Future <Utilisateur> getUtilisateur(String uid) async {
    DocumentSnapshot  snapshot = await fire_user.doc(uid).get();
    return Utilisateur(snapshot);

  }

  Future <String> stockageImage(String nameFile,Uint8List datas) async{
    TaskSnapshot snapshot = await fireStorage.ref("image/$nameFile").putData(datas);
    String urlChemin = await snapshot.ref.getDownloadURL();
    return urlChemin;
  }

  /*Future <String> searchUser(String name, Map<String, dynamic>map) async {
    String urlChemin = await snapshot.ref.getDownloadURL();
    return urlChemin;
  }*/





}