import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  var authenticate = FirebaseAuth.instance;

  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    var mobileWidth = MediaQuery.of(context).size.width;

    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Registration",
              style: TextStyle(
                  fontSize: 25,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.normal,
                  color: Colors.black),
            ),
            centerTitle: true,
            elevation: 5.0,
          ),
          body: Center(
            child: Container(
              width: mobileWidth,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Material(
                      child: TextField(
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
                    keyboardType: TextInputType.emailAddress,
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
                          // Remember to add .trim() function in EMail Address to get rid of the error of "Email Address Badly Formatted"!
                          var user =
                              await authenticate.createUserWithEmailAndPassword(
                            email: email.trim(),
                            password: password,
                          );

                          if (user.additionalUserInfo.isNewUser == true) {
                            Navigator.pushNamed(context, "/chat");
                          }
                        } catch (e) {
                          showDialog(
                            context: context,
                          );
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
                        "Login",
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () => Navigator.pushNamed(context, "/login"),
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