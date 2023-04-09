import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:crm/XYZ.dart';
import 'package:crm/Screens/Project/AddNewTask/CategoryCard.dart';
import 'package:firebase_database/firebase_database.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask>{
  final DatabaseReference refs = FirebaseDatabase.instance.reference().child('users');
  late TextEditingController _Titlecontroller;
  late TextEditingController _Datecontroller;
  late TextEditingController _Datecontrollers;
  late TextEditingController _StartTime;
  late TextEditingController _EndTime;
  final myDesc = TextEditingController();
  List<dynamic> dataList=[];
  List<String> data=[];
  DateTime SelectedDate = DateTime.now();
  DateTime SelectedDates = DateTime.now();
    String selectedC="";
    String selectedB="";
  late String selecteC="";
 late  String selecteB="";
  String selectedE="";
  late String selecteE="";
  String Category = "Meeting";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _Titlecontroller = new TextEditingController();
    _Datecontroller = new TextEditingController(
        text: '${DateFormat('EEE, MMM d, ' 'yy').format(this.SelectedDate)}');
    _Datecontrollers = new TextEditingController(
        text: '${DateFormat('EEE, MMM d, ' 'yy').format(this.SelectedDate)}');
    _StartTime = new TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now())}');
    _EndTime = new TextEditingController(
        text: '${DateFormat.jm().format(DateTime.now().add(
          Duration(hours: 1),
        ))}');
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDate = selected;
        _Datecontroller.text =
        '${DateFormat('EEE, MMM d, ' 'yy').format(selected)}';
      });
    }
  }
  _selectDates(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: SelectedDate,
      firstDate: DateTime(2005),
      lastDate: DateTime(2030),
    );
    if (selected != null && selected != SelectedDate) {
      setState(() {
        SelectedDates = selected;
        _Datecontrollers.text =
        '${DateFormat('EEE, MMM d, ' 'yy').format(selected)}';
      });
    }
  }

  _selectTime(BuildContext context, String Timetype) async {
    final TimeOfDay? result =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (result != null) {
      setState(() {
        if (Timetype == "StartTime") {
          _StartTime.text = result.format(context);
        } else {
          _EndTime.text = result.format(context);
        }
      });
    }
  }

  _SetCategory(String Category) {
    this.setState(() {
      this.Category = Category;
    });
  }
  String _selectedClient = '';
  List<String> _clientList = [];
  List<String> _clientLists = [];
  final _formKey = GlobalKey<FormState>();
  List<List<dynamic>> _selectedClients = [];
  int _numContainers = 1;
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: Color.fromRGBO(130, 0, 255, 1),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  padding:
                  EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back,
                            size: 30, color: Colors.white),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Text(
                        "Create New Project",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.montserrat(
                          color: Colors.white,
                          fontSize: 20,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: _Titlecontroller,
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    decoration: InputDecoration(
                      labelText: "Title",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: TextFormField(
                    controller: _Datecontroller,
                    cursorColor: Colors.white,
                    style: GoogleFonts.montserrat(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                    readOnly: true,
                    decoration: InputDecoration(
                      labelText: "Date",
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_month_outlined,
                          color: Colors.white,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      fillColor: Colors.white,
                      labelStyle: GoogleFonts.montserrat(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 530,
                  margin: EdgeInsets.only(top: 40),
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 20,left: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: TextFormField(
                                controller: _Datecontrollers,
                                cursorColor: Colors.black,
                                style: GoogleFonts.montserrat(
                                  color: Colors.black,
                                  fontSize: 15,
                                ),
                                readOnly: true,
                                decoration: InputDecoration(
                                  labelText: "End Date",
                                  suffixIcon: GestureDetector(
                                    onTap: () {
                                      _selectDates(context);
                                    },
                                    child: Icon(
                                      Icons.calendar_month_outlined,
                                      color: Colors.black
                                    ),
                                  ),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  fillColor: Colors.black,
                                  labelStyle: GoogleFonts.montserrat(
                                    color: Colors.black,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: FutureBuilder<DataSnapshot>(
                          future: FirebaseDatabase.instance.reference().child("users").once().then((event) => event.snapshot),
                          builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              Map<dynamic, dynamic>? value = snapshot.data!.value as Map<dynamic, dynamic>?;
                              if (value != null) {
                                List<String> op = value.values.map((value) => value["email"].toString()).toList();
                                 selectedE=op.first;
                                return DropdownButtonFormField(
                                  value: selectedE,
                                  items: op.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selecteE=value!;
                                      selectedE = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Select an client',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select an item';
                                    }
                                    return null;
                                  },
                                );
                              }
                            }
                            return Container();
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: FutureBuilder<DataSnapshot>(
                          future: FirebaseDatabase.instance.reference().child("users").once().then((event) => event.snapshot),
                          builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              Map<dynamic, dynamic>? value = snapshot.data!.value as Map<dynamic, dynamic>?;
                              if (value != null) {
                                List<String> op = value.values.map((value) => value["fullname"].toString()).toList();
                                selectedC=op.first;
                                return DropdownButtonFormField(
                                  value: selectedC,
                                  items: op.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      selecteC=value!;
                                      selectedC = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Select an client',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select an item';
                                    }
                                    return null;
                                  },
                                );
                              }
                            }
                            return Container();
                          },
                        ),
                      ),
                      SizedBox(height: 20,),
                      Container(
                        child: FutureBuilder<DataSnapshot>(
                          future: FirebaseDatabase.instance.reference().child("users").once().then((event) => event.snapshot),
                          builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                            if (snapshot.hasData) {
                              Map<dynamic, dynamic>? values = snapshot.data!.value as Map<dynamic, dynamic>?;
                              if (values != null) {
                                List<String> options = values.values.map((value) => value["fullname"].toString()).toList();
                                 selectedB=options.first;
                                return DropdownButtonFormField(
                                  value: selectedB,
                                  items: options.map((String value) {
                                    return DropdownMenuItem(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    print(value);
                                    setState(() {
                                      selecteB=value!;
                                      selectedB = value!;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Select an leads',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select an item';
                                    }
                                    return null;
                                  },
                                );
                              }
                            }
                            return Container();
                          },
                        ),
                      ),

                      SizedBox(height: 20,),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                          child: Text("submit project",style: TextStyle(color: Colors.white,fontSize: 15),),
                          onPressed: (){
                            final DatabaseReference da = FirebaseDatabase.instance.reference().child('projects');
                          da.push().set({
                           'projectName' :_Titlecontroller.text,
                           'startDate' :_Datecontroller.text,
                           'endDate' : _Datecontrollers.text,
                           'clientName' : selecteC,
                           'LeadName': selecteB,
                            'email': selecteE
                          });
                          },

                        ),
                      )
                    ],
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