import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/common/loading.dart';
import 'package:projetfinal_mobile/models/user.dart';
import 'package:projetfinal_mobile/pages/home/user_list.dart';
import 'package:projetfinal_mobile/services/FirestoreHelper.dart';
import 'package:projetfinal_mobile/services/database.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  final FirestoreHelper _auth = FirestoreHelper();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) throw Exception("user not found");
    final database = DatabaseService(user.uid);
    return StreamProvider<List<AppUserData>>.value(
      initialData: [],
      value: database.users,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          elevation: 0.0,
          title: Text('Social Lover'),
          actions: <Widget>[
            StreamBuilder<AppUserData>(
              stream: database.user,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  AppUserData? userData = snapshot.data;
                  if (userData == null) return Loading();
                  return TextButton.icon(
                    icon: Icon(
                      Icons.wine_bar,
                      color: Colors.white,
                    ),
                    label: Text('create love', style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      await database.saveUser(userData.name, userData.MsgCoin + 1);
                    },
                  );
                } else {
                  return Loading();
                }
              },
            ),
            TextButton.icon(
              icon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              label: Text('logout', style: TextStyle(color: Colors.white)),
              onPressed: () async {
                await _auth.signOut();
              },
            )
          ],
        ),
        body: UserList(),
      ),
    );
  }
}