import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crm/Screens/Project/AddNewTask/AddNewTask.dart';

import '../ProjectsPage/ProgressCard.dart';

class TasksPage extends StatefulWidget {
  const TasksPage({
    Key? key,
    required this.Goback,
  }) : super(key: key);
  final void Function(int) Goback;
  @override
  State<TasksPage> createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Color.fromRGBO(242, 244, 255, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(25),
              // decoration: BoxDecoration(
              //     color: Colors.white,
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(50),
              //       bottomRight: Radius.circular(50),
              //     )),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          color: Colors.black,
                          size: 30,
                        ),
                      ),
                      Icon(
                        Icons.search_rounded,
                        color: Colors.black,
                        size: 30,
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const AddNewTask()));
                        },
                        child: Container(
                          padding: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 123, 0, 245),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.add,
                                color: Colors.white,
                                size: 20,
                              ),
                              Text(
                                "Add Projects",
                                style: GoogleFonts.montserrat(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Center(
                   child:  Text(
                     "Projects",
                     style: GoogleFonts.montserrat(
                       color: Colors.black,
                       fontSize: 20,
                       fontWeight: FontWeight.w500,
                     ),
                   ),
                 ),
                  SizedBox(height:20),
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child:    Container(
                      child: FutureBuilder<DataSnapshot>(
                        future: FirebaseDatabase.instance.reference().child("projects").once().then((event) => event.snapshot),
                        builder: (BuildContext context, AsyncSnapshot<DataSnapshot> snapshot) {
                          if (snapshot.hasData) {
                            Map<dynamic, dynamic>? values = snapshot.data!.value as Map<dynamic, dynamic>?;
                            if (values != null) {
                              List<String> options = values.values.map((value) => value["projectName"].toString()).toList();
                              return Container(
                                child: SizedBox(
                                  height: 500,
                                  width: 400,
                                  child: ListView.builder(
                                    itemCount: options.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        padding: EdgeInsets.only(top: 10),
                                        margin: EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                          color: Color.fromARGB(255, 123, 0, 245),
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
                                          title: Text(options[index],style: TextStyle(color: Colors.white,fontSize: 23),),
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
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
