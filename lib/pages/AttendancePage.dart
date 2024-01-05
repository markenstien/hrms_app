import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bitbytes/assets/constants.dart';
import 'package:bitbytes/assets/helpers.dart';
import 'package:bitbytes/includes/Drawer.dart';
import 'package:bitbytes/pages/AttendanceView.dart';
import 'package:bitbytes/services/AttendanceService.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
class AttendaceMainPage extends StatefulWidget {
  const AttendaceMainPage({Key? key}) : super(key: key);

  @override
  State<AttendaceMainPage> createState() => _AttendaceMainPageState();
}

class _AttendaceMainPageState extends State<AttendaceMainPage> {
  AttendanceService attendanceService = AttendanceService();
  var userData = {};
  var attendanceList = [];

  Future fetchAttendance() async{
    var response = await attendanceService.getList(userData['id']);
    return response;
  }

  void getUserdata () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authUser = prefs.getString('authUser') ?? '';
    setState(() {
      userData = jsonDecode(authUser);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance'),
      ),
      drawer: const MainDrawer(),
      body: projectWidget(),
    );
  }

  Widget projectWidget() {
    return FutureBuilder(
      builder: (context, projectSnap) {
        if (!projectSnap.hasData) {
          //print('project snapshot data is: ${projectSnap.data}');
          return Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          itemCount: projectSnap.data.length ?? 0,
          itemBuilder: (context, index) {
            var attendanceRow = projectSnap.data[index];
            var durationOfWork = minutesToHours(attendanceRow['duration'].toString(), '');

            return ListTile(
              leading: Icon(Icons.timelapse_outlined),
              title: Text("${attendanceRow['time_in']} to ${attendanceRow['time_out']}"),
              trailing: Text(durationOfWork.toString()),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => AttendanceView(timeSheetData: attendanceRow,)));
              },
            );
          },
        );
      },
      future: fetchAttendance(),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserdata();
  }
}

class AttendanceItemView extends StatelessWidget {
  const AttendanceItemView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150.0,
          width: 190.0,
          padding: const EdgeInsets.only(top: 40),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
          ),
          child: Center(
            child: Image.network(PROFILE_PICTURE_LINK),
          ),
        ),
        Card(
          child: ListTile(
            leading: Icon(Icons.check_circle, color: Colors.greenAccent,),
            title: Text('10:00AM'),
            trailing: Icon(Icons.date_range, color: Colors.black12,semanticLabel: 'Date',),
          ),
        ),
        SizedBox(height: 12,),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Card(
                color: Colors.green,
                child: ListTile(title: Text('01/03/2024'),),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.red,
                child: ListTile(title: Text('01/03/2024'),),
              ),
            )
          ],
        ),

        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Card(
                color: Colors.green,
                child: ListTile(title: Text('10:00AM'),),
              ),
            ),
            Expanded(
              child: Card(
                color: Colors.red,
                child: ListTile(title: Text('12:00PM'),),
              ),
            )
          ],
        ),

        Card(
          child: ListTile(
            leading: Icon(Icons.check_circle, color: Colors.greenAccent,),
            title: Text('Approved')
          ),
        ),

        Card(
          child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.greenAccent,),
              title: Text('Approver name')
          ),
        ),

        Card(
          child: ListTile(
              leading: Icon(Icons.check_circle, color: Colors.greenAccent,),
              title: Text('Automatic')
          ),
        )
      ],
    );
  }
}

class AttendanceViewContent extends StatelessWidget {
  final List attendanceList;
  const AttendanceViewContent(this.attendanceList);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(itemCount : attendanceList.length,
          padding: const EdgeInsets.all(8),
          itemBuilder: (BuildContext context, int index) {
        return Container(
          color: Colors.amber,
          child: Center(child: Text('Sample Attendance'),),
        );
      })
    );
  }
}

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Column(
          children: [
            Text('Jan 03 - Jan 04'),
            Text('8:00 AM to 4:00PM'),
            Container(
              child: Text('PENDING'),
              color: Colors.red,
            )
          ],
        ),
      ),
      onTap: (){
        print('test');
      },
    );
  }
}
