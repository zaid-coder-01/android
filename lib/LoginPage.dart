import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crm/Dashboard.dart';
import 'package:crm/Screens/Admin_dashboard.dart';
import 'package:crm/Screens/DeveloperDashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginPage());
}
final DatabaseReference _usersRef = FirebaseDatabase.instance.reference().child('users');
class LoginPage extends StatelessWidget {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.fromRGBO(237, 237, 237, 1),
              Color.fromRGBO(237, 237, 237, 1)
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'LOGIN',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                    labelText: 'Email',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  prefixIcon: Icon(Icons.email),
                ),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                controller: passController,
                decoration: InputDecoration(
                  labelText: 'password',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  prefixIcon: Icon(Icons.lock),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
              ),
            ),
            SizedBox(
              height: 32,
            ),
            ElevatedButton(
              onPressed: () async {
                try{
                  FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passController.text,
                  ).then((data) {
                    final reference = FirebaseDatabase.instance.reference().child('users');
                    reference
                        .orderByChild('email')
                        .equalTo(emailController.text)
                        .onValue
                        .listen((event) {
                      DataSnapshot snapshot = event.snapshot;
                      Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
                      String mode= data.values.first['mode'];
                       if(mode=="client"){
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) =>MyHomePage()),
                         );
                       }
                      if(mode=="admin") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>Dashboard()),
                        );
                      }
                      if(mode=="bussiness developer") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>BDashboard()),
                        );
                      }
                    });
                  }).catchError((error) {
                    // Handle login errors
                    print(error);
                  });

                }
                catch(e){
                  print(e);
                }
              },
              child: Text(
                'Sign In',
                style: TextStyle(fontSize: 16,color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                padding:
                const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
            SizedBox(
              height: 16,
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
