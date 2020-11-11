import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class MyLogin extends StatefulWidget {
  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> with SingleTickerProviderStateMixin {
  var animation;

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    var animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _controller = animationController;
    animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn)
      ..addListener(() {
        setState(() {
          print(animation.value);
        });
      });
    print(animation);
    _controller.forward();
    print(animation);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  var authentication = FirebaseAuth.instance;

  String email, password;
  bool showProgressSpinner = false;

  @override
  Widget build(BuildContext context) {
    var mobileWidth = MediaQuery.of(context).size.width;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Text(
            "Login",
            style: TextStyle(
                fontSize: 25,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
                color: Colors.black),
          ),
          centerTitle: true,
          elevation: 5.0,
        ),
        body: ModalProgressHUD(
          inAsyncCall: showProgressSpinner,
          child: Center(
            child: Container(
              width: mobileWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                      child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email ID',
                      prefixIcon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                      labelStyle:
                          TextStyle(fontSize: 15.0, color: Colors.black),
                      hintText: "Enter your Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  )),
                  SizedBox(
                    height: 25,
                  ),
                  Material(
                      child: TextField(
                    keyboardType: TextInputType.multiline,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                      labelStyle:
                          TextStyle(fontSize: 15.0, color: Colors.black),
                      hintText: "Enter your Password",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1.5),
                      ),
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  )),
                  SizedBox(
                    height: 25,
                  ),
                  Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 15,
                    child: MaterialButton(
                      minWidth: 250,
                      child: Text(
                        "Submit",
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          setState(() {
                            showProgressSpinner = true;
                          });
                          var user =
                              await authentication.signInWithEmailAndPassword(
                            email: email.trim(),
                            password: password,
                          );

                          if (user != null) {
                            Navigator.pushNamed(context, "/chat");
                            setState(() {
                              showProgressSpinner = false;
                            });
                          } else {
                            setState(() {
                              showProgressSpinner = false;
                            });
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 25,
                    child: Card(
                        elevation: 1.0,
                        color: Colors.black,
                        child: Text(
                          "OR",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Material(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(10),
                    elevation: 15,
                    child: MaterialButton(
                      minWidth: 250,
                      child: Text(
                        "Create an Account ?",
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () =>
                          Navigator.pushNamed(context, "/registration"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}