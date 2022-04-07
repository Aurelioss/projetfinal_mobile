import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:projetfinal_mobile/login.dart';
import 'package:projetfinal_mobile/register.dart';
import 'package:projetfinal_mobile/resetpass.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/pages/splashscreen_wrapper.dart';
import 'package:projetfinal_mobile/services/FirestoreHelper.dart';
import 'package:provider/provider.dart';

import 'models/chat_params.dart';
import 'models/user.dart';
import 'pages/chat/chat_screen.dart';


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());

  /*runApp(
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
  );*/
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<AppUser?>.value(
      value: FirestoreHelper().user,
      initialData: null,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        onGenerateRoute: (settings) => RouteGenerator.generateRoute(settings),
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }


}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/' :
        return MaterialPageRoute(builder: (context) => SplashScreenWrapper());
      case '/chat':
        var arguments = settings.arguments;
        if (arguments != null) {
          return PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  ChatScreen(chatParams: arguments as ChatParams),
              transitionsBuilder: (context, animation, secondaryAnimation,
                  child) {
                animation =
                    CurvedAnimation(curve: Curves.ease, parent: animation);
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              }
          );
        } else {
          return pageNotFound();
        }
      default:
        return pageNotFound();
    }
  }

  static MaterialPageRoute pageNotFound() {
    return MaterialPageRoute(
        builder: (context) =>
            Scaffold(
                appBar: AppBar(title: Text("Error"), centerTitle: true),
                body: Center(
                  child: Text("Page not found"),
                )
            )
    );
  }
}


