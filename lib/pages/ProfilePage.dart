import 'dart:convert';

import 'package:bitbytes/assets/constants.dart';
import 'package:bitbytes/includes/Drawer.dart';
import 'package:bitbytes/pages/AttendanceQRPage.dart';
import 'package:bitbytes/services/AttendanceService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  var userData = {};
  var attendanceState = {};
  int _selectedIndex = 0;

  AttendanceService attendanceService = AttendanceService();
  List<Widget> _widgetOptions = <Widget> [];

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      drawer: const MainDrawer(),
      bottomNavigationBar: NavigationBar(
        destinations: [
          NavigationDestination(icon: Icon(Icons.dashboard), label: 'General'),
          NavigationDestination(icon: Icon(Icons.corporate_fare), label: 'Work'),
        ],
        selectedIndex: _selectedIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ) ,
      body: <Widget>[
        SingleChildScrollView(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 150.0,
                  width: 190.0,
                  padding: EdgeInsets.only(top: 40),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(200),
                  ),
                  child: Center(
                    child: Image.network(userData['profile_url'] ?? PROFILE_PICTURE_LINK),
                  ),
                ),
                SizedBox(height: 12,),
                Container(
                  child: generalInfo(),
                )
              ],
            ),
          ),
        ),
        workInfo()
      ][_selectedIndex],
    );
  }
  Widget generalInfo() {
    return Column(
      children: [
        Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(userData['firstname'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.rocket_launch_sharp),
                title: Text(userData['position_name'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.corporate_fare),
                title: Text(userData['department_name'] ?? ''),
              ),
            ),
            InkWell(
              child: Card(
                child: timeSheetStatus(attendanceState['currentStatus']),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => AttendanceQRPage()));
              },
            )
          ],
        )
      ],
    );
  }

  Widget workInfo() {
    return Column(
      children: [
        Column(
          children: [
            Card(
              child: ListTile(
                leading: Icon(Icons.rocket_launch_sharp),
                title: Text("${fetchuserData('department_name')}/${fetchuserData('position_name')}"),
                trailing: Text('Dept/Pos'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.library_add_check),
                title: Text(userData['hire_date'] ?? ''),
                trailing: Text('Hire Date'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.calendar_today_rounded),
                title: Text(userData['shift_name'] ?? ''),
                trailing: Text('Shift'),
              ),
            ),
            SizedBox(height: 30,),
            Card(
              child: ListTile(
                leading: Icon(Icons.email),
                title: Text(userData['email'] ?? ''),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(userData['mobile_number'] ?? ''),
              ),
            ),
            SizedBox(height: 30,),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(userData['sss_number'] ?? ''),
                trailing: Text('SSS'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(userData['phil_health_number'] ?? ''),
                trailing: Text('PHILHEALTH'),
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text(userData['pagibig_number'] ?? ''),
                trailing: Text('PAGIBIG'),
              ),
            ),
          ],
        )
      ],
    );
  }

  void getUserdata () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authUser = prefs.getString('authUser') ?? '';
    var authData = jsonDecode(authUser);
    getAttendanceStatus(authData['id']);
    setState(() {
      userData = jsonDecode(authUser);
    });
  }

  String fetchuserData(key) {
    return userData[key] ?? '';
  }

  void getAttendanceStatus (userId) async {
    var attendanceStatus = await attendanceService.getStatus(userId);
    setState(() {
      attendanceState = attendanceStatus;
    });
  }

  Widget timeSheetStatus(status) {
    if(status == 'login') {
      return ListTile(
        leading: Icon(Icons.cancel, color: Colors.red),
        title: Text('Currently Clocked Out'),
      );
    } else {
      return ListTile(
        leading: Icon(Icons.check_circle, color: Colors.green),
        title: Text('Currently Clocked In'),
      );
    }
  }


  @override
  void initState() {
    super.initState();
    getUserdata();
    _widgetOptions.add(workInfo());
    _widgetOptions.add(Text('Personal'));
  }
}
