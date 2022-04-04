import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/functions/customPageRoute.dart';
import 'package:projetfinal_mobile/functions/FirestoreHelper.dart';
import 'package:projetfinal_mobile/register.dart';
import 'package:projetfinal_mobile/homepage.dart';


class myLogin extends StatefulWidget {
  const myLogin({Key? key}) : super(key: key);

  @override
  _myLoginState createState() => _myLoginState();
}

class _myLoginState extends State<myLogin> {


  late String mail = "";
  late String password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [Colors.orange, Colors.lightGreen]
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      top: 60.0,
                    ),
                    child: Text(
                      'LOGIN',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.5,
                    left: 35,
                    right: 35,
                  ),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        onChanged: (value) {
                          mail = value;
                        },
                      ),
                      SizedBox(height: 30.0),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter the password';
                          } else if (value.length <= 6) {
                            return 'Password must be greator than 6 digits';
                          }
                        },
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          filled: true,
                          // hintText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
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
                            //forme
                              style: ElevatedButton.styleFrom(
                                maximumSize: Size(170.0, 90.0),
                                minimumSize: Size(170.0, 60.0),
                                primary: Colors.black,
                                shape: StadiumBorder(),
                              ),
                              //action
                              onPressed: () async {
                                if (isLoading) return;
                                print("Je me suis connecté");
                                FirestoreHelper().Connexion(mail, password).then((value){
                                  print("Connexion réussi");

                                  Navigator.of(context).push(
                                    CustomPageRoute(
                                      child: HomePage(),
                                      direction: AxisDirection.up,
                                    ),
                                  );
                                }).catchError((onError){
                                  print("Connexion erroné");
                                });

                                setState(() => isLoading = true);
                                await Future.delayed(Duration(seconds: 3));
                                setState(() => isLoading = false);
                              },

                              //contenu
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                //crossAxisAlignment: CrossAxisAlignment.center,
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
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.lock,
                                          color: Colors.white,
                                        ),
                                        Text('LOG IN'),

                                      ]
                                  ),
                                ],
                              )),
                        ],
                      ),
                      SizedBox(height: 30.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            //du bas vers le haut
                            onPressed: () => Navigator.of(context).push(
                              CustomPageRoute(
                                child: myRegister(),
                                direction: AxisDirection.up,
                              ),
                            ),
                              //Navigator.pushNamed(context, 'register');

                            child: Text(
                              'Register',
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
