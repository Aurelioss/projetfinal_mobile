import 'package:firebase_auth/firebase_auth.dart';
import 'package:projetfinal_mobile/models/user.dart';
import 'package:projetfinal_mobile/services/database.dart';


class FirestoreHelper {
  //Attributs
  final _auth = FirebaseAuth.instance;


  AppUser? _userFromFirebaseUser(User? user) {
    return user != null ? AppUser(user.uid) : null;
  }

  Stream<AppUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //méthode

//Pour l'inscription
  Future signIn(String mail,String password) async {

    try {
      UserCredential resultat = await _auth.createUserWithEmailAndPassword(email: mail, password: password);
      User? user = resultat.user;
      return _userFromFirebaseUser(user);
    } catch(exception){
      print(exception.toString());
      return null;
    }


  }

  Future registerWithEmailAndPassword(String name, String email, String password) async {
    try {
      UserCredential result =
      await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? user = result.user;
      if (user == null) {
        throw Exception("No user found");
      } else {
        await DatabaseService(user.uid).saveUser(name, 0);

        return _userFromFirebaseUser(user);
      }
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (exception) {
      print(exception.toString());
      return null;
    }
  }

  Future <String> getIdentifiant() async{
    String uid = _auth.currentUser!.uid;
    return uid;
  }

  /*Future <String> searchUser(String name, Map<String, dynamic>map) async {
    String urlChemin = await snapshot.ref.getDownloadURL();
    return urlChemin;
  }*/





}