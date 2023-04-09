import 'package:flutter/material.dart';
import 'package:crm/Screens/ProjectProgress.dart';
import 'package:crm/Screens/DeveloperProfile.dart';
import 'package:crm/Screens/ProjectDeatil.dart';

class BDashboard extends StatefulWidget {
  const BDashboard({Key? key}): super(key: key);
  @override
  State<BDashboard> createState() => _BDashboardState();
}

class _BDashboardState extends State<BDashboard> with TickerProviderStateMixin{
  late TabController tabController;
  @override
  void initState() {
    // ignore: unnecessary_new
    tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }
  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xAAC7C6C6),
        leading: IconButton(
          icon: Icon(Icons.menu), // change this to the desired icon
          onPressed: () => _scaffoldKey.currentState?.openDrawer(),
        ),
        iconTheme: IconThemeData(
          color: Colors.black, // change this to the desired color
        ),

        title: Text(
          'Developer Dashboard',
          style: TextStyle(
            color: Colors.black, // change this to the desired color
          ),

        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: const Text('xyz'),
              accountEmail: const Text('xyz@example.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('About'),
              onTap: () {
                // Navigate to about screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.help),
              title: const Text('Help'),
              onTap: () {
                // Navigate to help screen
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Perform logout action
              },
            ),
          ],
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
                Expanded(child: Container(
                  //padding: EdgeInsets.only(top: 50.0),
                  margin: EdgeInsets.only(right: 10, left: 10),
                  width: 165,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF90B1D2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      //Navigate to Meetings page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Project()),
                      );
                    },
                    child: Text(
                      textAlign: TextAlign.center,
                      'Project Details',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                ),
                // Expanded(child: Container(
                //   //padding: EdgeInsets.only(top: 30.0),
                //   margin: EdgeInsets.only(right: 10),
                //   width: 165,
                //   height: 100,
                //   decoration: BoxDecoration(
                //     color: Color(0xFF90B1D2),
                //     borderRadius: BorderRadius.circular(10),
                //   ),
                //   child: TextButton(
                //     onPressed: () {
                //       // Navigate to User management page
                //     },
                //     child: Text(
                //       textAlign: TextAlign.center,
                //       'User Management',
                //       style: TextStyle(
                //         color: Colors.white,
                //         fontSize: 20,
                //       ),
                //     ),
                //   ),
                // ),
                // )
              ],
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Expanded(child: Container(
                  margin: EdgeInsets.only(right: 10, left: 10),
                  width: 165,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF90B1D2),
                    borderRadius: BorderRadius.circular(10),
                  ),

                  child: TextButton(
                    onPressed: () {
                      // Navigate to Leads page
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
                ),
                Expanded(child: Container(
                  margin: EdgeInsets.only(right: 10),
                  width: 165,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Color(0xFF90B1D2),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProjectStatusScreen()),
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
                ),


              ],
            ),
            // All,Today,Tomorrow
            SizedBox(height: 20),
            Row(

              children: [
                Expanded(
                  child: TabBar(
                    controller: tabController,
                    labelColor: Colors.black,
                    isScrollable: true,
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                    ),
                    padding: EdgeInsets.all(0),
                    unselectedLabelColor: Colors.grey.shade400,
                    tabs: [
                      Container(
                        width: screenWidth / 4,
                        child: Tab(
                          text: "All",
                        ),
                      ),
                      Container(
                        width: screenWidth / 4,
                        child: Tab(
                          text: "Today",
                        ),
                      ),
                      Container(
                        width: screenWidth /4,
                        child: Tab(
                          text: "Tomorrow",
                        ),
                      ),

                    ],
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
                      icon: Icon(Icons.add),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.person),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => developerP()),
                        );
                      },
                    ),

                    // IconButton(
                    //   icon: Icon(Icons.meeting_room),
                    //   onPressed: () {
                    //     // Project button logic
                    //   },
                    // ),
                    // IconButton(
                    //   icon: Icon(Icons.folder),
                    //   onPressed: () {
                    //     // Dashboard button logic
                    //
                    //   },
                    // ),
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
