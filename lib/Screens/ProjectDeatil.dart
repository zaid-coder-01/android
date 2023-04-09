
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Project extends StatefulWidget {
  @override
  HomePag createState() => HomePag();
}

class HomePag extends State<Project> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference refs = FirebaseDatabase.instance.reference().child('users');
  User? _user;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.only(top: 30),
          child: FutureBuilder<DataSnapshot>(
            future: FirebaseDatabase.instance.reference().child("projects").orderByChild("email").equalTo(_user!.email).once().then((event) => event.snapshot),
            builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                Map<dynamic, dynamic>? values = snapshot.data!.value as Map<dynamic, dynamic>?;
                if (values != null) {
                  List<dynamic> list = values.values.toList();
                  List<String> options = [];
                  for (var value in list) {
                    options.add(value["LeadName"].toString());
                    options.add(value["clientName"].toString());
                    options.add(value["projectName"].toString());
                  }
                  // List<String> options = values.values.map((value) => value["fullname"].toString()).toList();
                  return Container(
                    child: SizedBox(
                      height: 270,
                      width: 400,
                      child: ListView.builder(
                        itemCount: options.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.only(top: 10),
                            margin: EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 1,
                                  blurRadius: 3,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: ListTile(
                              title: Text(options[index],style: TextStyle(color: Colors.black,fontSize: 23),),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              }
              return Container();
            },
          ),
        ),
      ),
    );
  }
}