import 'package:flutter/material.dart';

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              "Chat App",
              style: TextStyle(
                fontSize: 25,
                color: Colors.black,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.normal,
              ),
            ),
            elevation: 5.0,
            centerTitle: true,
          ),
          body: Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Material(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(10),
                  elevation: 15,
                  child: MaterialButton(
                      minWidth: 250,
                      child: Text(
                        "Registration",
                        style: TextStyle(
                          fontSize: 25,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/registration");
                      }),
                ),
                SizedBox(
                  height: 50,
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
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
