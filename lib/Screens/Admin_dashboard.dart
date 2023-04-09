import 'package:flutter/material.dart';
import 'package:crm/Screens/Add.dart';
import 'package:crm/Screens/Meetings/Meeting.dart';
import 'package:crm/Screens/Project/ProjectPage.dart';
import 'package:crm/Screens/addUser.dart';
import 'package:crm/UserManage.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}): super(key: key);
  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xAAC7C6C6),
        leading: IconButton(
          icon: Icon(Icons.menu), // change this to the desired icon
          onPressed: () {
            // do something when the icon is pressed
          },
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // change this to the desired color
        ),
        title: Text(
            'Admin Dashboard',
          style: TextStyle(
            color: Colors.black, // change this to the desired color
          ),

        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.only(top: 50.0),
                  width: 165,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF90B1D2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      //Navigate to Meetings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Meeting(Goback: (int ) {

                        },
                        )
                        ),
                      );
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Meetings',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                Container(
                  //padding: EdgeInsets.only(top: 30.0),
                  width: 165,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF90B1D2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => UserManage()),
                      );
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'User Management',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // Container(
            //   height: 1, // set the height of the border
            //   decoration: BoxDecoration(
            //     border: Border(
            //       bottom: BorderSide(
            //         color: Colors.grey, // set the color of the border
            //         width: 2, // set the width of the border
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  width: 165,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF90B1D2),
                    borderRadius: BorderRadius.circular(0),
                  ),

                  child: TextButton(
                    onPressed: () {
                      // Navigate to Leads page
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Leads',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),

                Container(
                  width: 165,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF90B1D2),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to Project status page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Project status',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            // All,Today,Tomorrow
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  //padding: EdgeInsets.only(top: 20.0),
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xAAC7C6C6),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to All meetings
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'All',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  //padding: EdgeInsets.only(top: 20.0),
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xAAC7C6C6),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // Navigate to today's meeting
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Today',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  //padding: EdgeInsets.only(top: 20.0),
                  width: 120,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Color(0xAAC7C6C6),
                    borderRadius: BorderRadius.circular(0),
                  ),
                  child: TextButton(
                    style: TextButton.styleFrom(
                      alignment: Alignment.center, // Align text to the center of the button
                    ),
                    onPressed: () {
                      // Navigate to tomorrow's meeting
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Tomorrow',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () {
                          // Add button logic
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.person),
                        onPressed: () {
                          // Contact button logic
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Users()),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.meeting_room),
                        onPressed: () {
                          // Project button logic
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.folder),
                        onPressed: () {
                          // Dashboard button logic
                        },
                      ),
                    ],
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
