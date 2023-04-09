import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:crm/Dashboard.dart';
import 'package:crm/Screens/Admin_dashboard.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Users());
}
class Users extends StatefulWidget {
  @override
  PPage createState() => PPage();
}
class PPage extends State<Users> {
  final _formKey = GlobalKey<FormState>();
  String? selectedValue = null;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usertypeController = TextEditingController();
  final locationController = TextEditingController();
  final roleControl = TextEditingController();
  final specControl = TextEditingController();

  late List<String> items = [
    'client',
    'bussiness developer',
  ];
  late String selectedItem=items.first;
  late bool show=false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 80),
              Center(
                child: Text("ADD USERS",style: TextStyle(color: Colors.black,fontSize: 26,fontWeight: FontWeight.bold)),
              ),
              SizedBox(height: 36),
              DropdownButtonFormField(
                value: selectedItem,
                items: items.map((String value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    selectedItem = value!;
                     show=selectedItem=='bussiness developer';
                  });
                },
                decoration: InputDecoration(
                  labelText: 'Select an item',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null) {
                    return 'Please select an item';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),

              TextFormField(
                controller: nameController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                obscureText: true,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              Visibility(
                visible:show,
                child: TextFormField(
                  controller: specControl ,
                  decoration: InputDecoration(
                    labelText: 'specialization',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Visibility(
                visible:show,
                child: TextFormField(
                  controller: roleControl,
                decoration: InputDecoration(
                  labelText: 'Role',
                  border: OutlineInputBorder(),
                ),
              ),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  if (selectedItem =="bussiness developer") {
                    final da = FirebaseDatabase.instance.reference().child('users');
                    try {
                      // Create a new user in Firebase Authentication
                      UserCredential userCredential = await FirebaseAuth
                          .instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      await da.push().set({
                        'fullname': nameController.text,
                        'email': emailController.text,
                        'password': passwordController.text,
                        'mode': selectedItem,
                        'specialization': specControl.text,
                        'role': roleControl.text,
                      });
                      print('User added successfully to Firebase');
                    } catch (e) {
                      print('Error adding user to Firebase: $e');
                    }
                  }
                  if(selectedItem =="client") {
                  final databaseReference = FirebaseDatabase.instance.reference().child('users');
                    try {
                      // Create a new user in Firebase Authentication
                      UserCredential userCredential = await FirebaseAuth
                          .instance.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      await databaseReference.push().set({
                        'fullname': nameController.text,
                        'email': emailController.text,
                        'password': passwordController.text,
                        'mode': selectedItem,
                      });
                      print('User added successfully to Firebase');
                    } catch (e) {
                      print('Error adding user to Firebase: $e');
                    }
                  }
                },
                child: Container(
                  height: 40,
                  padding: EdgeInsets.only(top: 5),
                  child: Text('Register',style: TextStyle(color: Colors.black,fontSize: 26)),
                  ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
