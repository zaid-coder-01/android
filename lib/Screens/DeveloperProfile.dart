import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';


class developerP extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<developerP> {
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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(height: 40),
          Container(
            padding: EdgeInsets.all(16.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/profile_image.jpg'),
              radius: 80.0,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            _user != null ? (_user!.email ?? '').toString() : 'No user logged in',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child:    Container(
                child: FutureBuilder<DataSnapshot>(
                  future: FirebaseDatabase.instance.reference().child("users").orderByChild("email").equalTo(_user!.email).once().then((event) => event.snapshot),
                  builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic>? values = snapshot.data!.value as Map<dynamic, dynamic>?;
                      if (values != null) {
                        List<dynamic> list = values.values.toList();
                        List<String> options = [];
                        for (var value in list) {
                          options.add(value["fullname"].toString());
                          options.add(value["password"].toString());
                          options.add(value["email"].toString());
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
          ),
        ],
      ),
    );
  }
}
