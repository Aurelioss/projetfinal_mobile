import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/login.dart';
import 'package:projetfinal_mobile/register.dart';
import 'package:projetfinal_mobile/resetpass.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(fontFamily: 'Oswald'),
      debugShowCheckedModeBanner: false,
      initialRoute: 'login',
      title: 'OMS',
      routes: {
        'login': (context) => myLogin(),
        'register': (context) => myRegister(),
        'forgot': (context) => resetPassword(),
      },
    ),
  );
}
