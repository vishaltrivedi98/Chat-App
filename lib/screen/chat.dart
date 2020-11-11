import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with SingleTickerProviderStateMixin {
  String message;

  var fs = FirebaseFirestore.instance;
  var authenticate = FirebaseAuth.instance;
  var messageTextContoller = TextEditingController();
  var showProgressSpinner = false;
  var animation;

  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
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

  @override
  Widget build(BuildContext context) {
    var mobileWidth = MediaQuery.of(context).size.width;
    var mobileHeight = MediaQuery.of(context).size.height;
    var user = authenticate.currentUser.email;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Chat",
          style: TextStyle(
              fontSize: 25,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.normal,
              color: Colors.black),
        ),
        centerTitle: true,
        elevation: 5.0,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.location_on,
                color: Colors.black,
              ),
              onPressed: () async {
                Navigator.pushNamed(context, "/location");
              }),
          IconButton(
            icon: Icon(
              Icons.logout,
              color: Colors.black,
            ),
            onPressed: () async {
              await authenticate.signOut();
              Navigator.pushNamed(context, "/login");
            },
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30.0,
              ),
              Container(
                width: mobileWidth * 1.00,
                child: TextField(
                  onChanged: (value) {
                    message = value;
                  },
                  controller: messageTextContoller,
                  decoration: InputDecoration(
                    labelText: 'Enter Your Message',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.black,
                    ),
                    labelStyle: TextStyle(fontSize: 15.0, color: Colors.black),
                    hintText: "Message",
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black, width: 1.5),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              GestureDetector(
                onDoubleTap: () {
                  _controller.forward(from: 0.0);
                },
                child: Container(
                  child: RaisedButton(
                    color: Colors.black,
                    child: Text(
                      "Send",
                      style: TextStyle(
                        fontSize: 20,
                        fontStyle: FontStyle.italic,
                        color: Colors.white,
                      ),
                    ),
                    onPressed: () async {
                      messageTextContoller.clear();
                      await fs.collection("chatMessages").add({
                        "Message": message,
                        "Sender": user,
                      });
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Material(
                color: Colors.black,
                borderRadius: BorderRadius.circular(10),
                elevation: 15,
                child: MaterialButton(
                  minWidth: 200,
                  child: Text(
                    "Know Your Identity",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    try {
                      var user = authenticate.currentUser;
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                "Identity",
                                style: TextStyle(color: Colors.white),
                              ),
                              backgroundColor: Colors.black,
                              actions: [
                                FlatButton(
                                  child: Text(
                                    "OK",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                              content: Text(
                                "${user.email}",
                                style: TextStyle(color: Colors.white),
                              ),
                            );
                          });
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              SizedBox(
                height: 30.0,
                child: Text(
                  "Chat",
                  style: TextStyle(
                    backgroundColor: Colors.black,
                    color: Colors.white,
                    fontSize: 20.0,
                  ),
                ),
              ),
              Card(
                child: SizedBox(
                  height: mobileHeight * 0.68,
                  child: StreamBuilder<QuerySnapshot>(
                    builder: (context, snapshot) {
                      if (snapshot.data == null) {
                        return CircularProgressIndicator();
                      }

                      var m = snapshot.data.docs;
                      List<Widget> z = [];

                      for (var doc in m) {
                        z.add(
                          Text(
                            "${doc.data()['Sender']} : ${doc.data()['Message']}",
                          ),
                        );
                      }
                      // Using LitsView to show the messages Properly!
                      return Container(
                        height: mobileHeight * 0.3,
                        width: mobileWidth * 0.9,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: z.length,
                            itemBuilder: (BuildContext context, int index) {
                              return new ListTile(
                                title: z[index],
                              );
                            }),
                      );
                    },
                    stream: fs.collection("chatMessages").snapshots(),
                  ),
                ),
                elevation: 5.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}