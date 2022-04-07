import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/models/user.dart';
//import 'package:projetfinal_mobile/pages/authenticate/authenticate_screen.dart';
//import 'package:projetfinal_mobile/pages/home/home_screen.dart';

import 'package:projetfinal_mobile/login.dart';
import 'package:projetfinal_mobile/pages/home/homePage.dart';
import 'package:projetfinal_mobile/pages/authentification/authentification_screen.dart';

import 'package:provider/provider.dart';

class SplashScreenWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AppUser?>(context);
    if (user == null) {
      return AuthentificationScreen();
    } else {
      return HomePage();
    }
  }
}