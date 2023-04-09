import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  final List<String> _routeNames = <String>[    '/',    '/contact',    '/profile', '/search'];

  final List<Widget> _widgetOptions = <Widget>[    HomePage(),  SearchPage(),ProfilePage(), SearchPage(),];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client Dashboard'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,color: Colors.black,size: 35),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search,color: Colors.black,size: 35),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart,color: Colors.black,size: 35),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,color: Colors.black,size: 35),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
class HomePage extends StatefulWidget {
  @override
  HomePag createState() => HomePag();
}

class HomePag extends State<HomePage> {
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
class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
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

class ProfilePage extends StatefulWidget {
  @override
  PPage createState() => PPage();
}
class PPage extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue = null;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Center(
                child: Text("ADD USERS"),
              ),
              SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),

              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                },
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Bottom Navigation Demo',
    initialRoute: '/',
    routes: {
      '/': (context) => MyHomePage(),
      '/search': (context) => SearchPage(),
      '/profile': (context) => ProfilePage(),
    },
  ));
}
