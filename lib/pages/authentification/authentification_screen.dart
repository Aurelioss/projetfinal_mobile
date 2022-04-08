import 'package:flutter/material.dart';
import 'package:projetfinal_mobile/common/constants.dart';
import 'package:projetfinal_mobile/common/loading.dart';
import 'package:projetfinal_mobile/services/FirestoreHelper.dart';
import 'package:projetfinal_mobile/login.dart';
import 'package:projetfinal_mobile/register.dart';

class AuthentificationScreen extends StatefulWidget {
  @override
  _AuthentificationScreenState createState() => _AuthentificationScreenState();
}

class _AuthentificationScreenState extends State<AuthentificationScreen> {

  final FirestoreHelper _auth = FirestoreHelper();
  final _formKey = GlobalKey<FormState>();
  String error = '';
  bool loading = false;
  bool isLoading = false;

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();
  bool showSignIn = true;


  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleView() {
    setState(() {
      _formKey.currentState?.reset();
      error = '';
      emailController.text = '';
      nameController.text = '';
      passwordController.text = '';
      showSignIn = !showSignIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : LoginRegister() ;
  }


  LoginRegister(){
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
                      top: MediaQuery.of(context).size.height * 0.4,
                      left: 35,
                      right: 35,
                    ),
                    child: Form(
                      key: _formKey,
                      child:
                    Column(
                      children: [
                        !showSignIn
                            ?
                        TextFormField(
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: 'name',
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                          validator: (value) =>
                          value == null || value.isEmpty ? "Enter a name" : null,

                        ) : Container(),
                        !showSignIn ? SizedBox(height: 30.0) : Container(),

                        TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                            labelText: 'email',
                            filled: true,
                            // hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                          ),
                          validator: (value) =>
                          value == null || value.isEmpty ? "Enter an email" : null
                          ,
                        ),
                        SizedBox(height: 30.0),
                        TextFormField(
                          controller: passwordController,
                          decoration: InputDecoration(
                            labelText: 'password',
                            filled: true,
                            // hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),

                          ),
                          obscureText: true,
                          validator: (value) => value != null && value.length < 6
                              ? "Enter a password with at least 6 characters"
                              : null,
                        ),
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

                                  if (_formKey.currentState?.validate() == true) {
                                    setState(() => loading = true);
                                    var password = passwordController.value.text;
                                    var email = emailController.value.text;
                                    var name = nameController.value.text;

                                    dynamic result = showSignIn
                                        ? await _auth.signIn(email, password)
                                        : await _auth.registerWithEmailAndPassword(name, email, password);
                                    if (result == null) {
                                      setState(() {
                                        loading = false;
                                        error = 'Please supply a valid email';
                                      });
                                    }
                                  }
                                  await Future.delayed(Duration(seconds: 3));
                                },

                                //contenu

                                child: Row(

                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
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
                                          Text(
                                            showSignIn ? "Sign In" : "Register",
                                          ),

                                        ]
                                    ),
                                  ]
                                )),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              //du bas vers le haut
                            onPressed: () => toggleView(),
                              //Navigator.pushNamed(context, 'register');

                              child: Text(
                                showSignIn ? "Register" : 'Sign In',
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
                ),
              ],
            ),
          ),
        ),
      );
    }


}