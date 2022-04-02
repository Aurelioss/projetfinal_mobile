import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/login.dart';
import 'package:projetfinal_mobile/functions/customPageRoute.dart';
import 'package:projetfinal_mobile/functions/FirestoreHelper.dart';
import 'package:flutter_beautiful_popup/main.dart';

class myRegister extends StatefulWidget {
  const myRegister({Key? key}) : super(key: key);

  @override
  _myRegisterState createState() => _myRegisterState();
}

class _myRegisterState extends State<myRegister> {

  late String username;
  late String mail = "";
  late String password;
  bool isLoading = false;

  Future showPopUp(titlePopUp, description) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(titlePopUp),
        content: Text(description),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context, false),
          ),
        ],
      ),
  );

  void showAlert() {
    AlertDialog dialog = new AlertDialog(
      content: new Container(
        width: 260,
        height: 230,
        decoration: new BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: new BorderRadius.all(new Radius.circular(32)),
        ),
        child: new Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //top
            new Expanded(
                child: new Row(
                  children: <Widget>[
                    new Container(
                      decoration: new BoxDecoration(
                        color: Colors.green,
                      ),
                      child: new Text(
                          'Rate',
                           style: TextStyle(
                             color: Colors.black,
                             fontSize: 18,
                           ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  ],
                )
            ),
            //centre
            new Expanded(
                child: new Container(
                  child: new TextField(
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      filled: false,
                      contentPadding: new EdgeInsets.only(
                        left: 10, top: 10, bottom: 10, right: 10,
                      ),
                      hintText: 'add review',
                      hintStyle: new TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                      ),
                    )),
                  flex: 2,
                ),
              //Bottom
              new Expanded(
                child: new Container(
                  padding: new EdgeInsets.all(16),
                  decoration: new BoxDecoration(
                    color: Colors.purple,
                ),
                child: new Text(
                  'Rate prduct',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          //color: Colors.lightGreenAccent
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.purple, Colors.orange]
          ),
        ),
        child: Scaffold(
          appBar: AppBar(
              elevation: null,
              backgroundColor: Colors.transparent,
              leading: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'login');
                },
                child: Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.white,
                ),
              )),
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'REGISTER\n',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40.0,
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.28,
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Username',
                          filled: true,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(
                                color: Colors.white,
                              )),
                        ),
                        onChanged: (value) {
                          username = value;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextField(
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          mail = value;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: const BorderSide(
                              color: Colors.white,
                            ),
                          ),
                        ),
                        onChanged: (value) {
                          password = value;
                        },
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton(
                            //forme bouton
                              style: ElevatedButton.styleFrom(
                                maximumSize: const Size(170.0, 90.0),
                                minimumSize: const Size(170.0, 60.0),
                                primary: Colors.black,
                                shape: const StadiumBorder(),
                              ),
                              //action bouton
                              onPressed: () async {
                                showAlert();
                                if (isLoading) return;
                                setState(() => isLoading = true);
                                await Future.delayed(Duration(seconds: 3));
                                setState(() => isLoading = false);

                                if (password.length < 6) {
                                  showPopUp('Error', 'Password must get at least 6 characters');
                                } else {
                                  if (mail.length == 0){
                                    showPopUp('Error', 'Invalid mail');
                                  } else {
                                    if (username.length == 0){
                                      showPopUp('Error', 'Invalid username');
                                    } else {
                                      FirestoreHelper().Inscription(mail, password, username);
                                      showPopUp('Succesz', 'Your account as been create succesfully !');
                                    }
                                  }
                                }
                              },
                              //contenu dans le bouton
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  isLoading
                                      ? Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          CircularProgressIndicator(color: Colors.white),
                                          const SizedBox(width: 12),
                                          Text('Please wait...'),
                                        ],
                                      )
                                      : Row(
                                        children: [
                                          Icon(
                                            Icons.content_paste_rounded,
                                            color: Colors.white,
                                          ),
                                          Text('REGISTER'),
                                    ]),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            //je veux transition haut vers bas
                            /*onPressed: () {
                              Navigator.pushNamed(context, 'login');
                            },*/
                            onPressed: () => Navigator.of(context).push(
                              CustomPageRoute(
                                  child: myLogin(),
                                  direction: AxisDirection.down,
                              ),
                            ),
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'forgot');
                            },
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
