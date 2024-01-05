import 'package:bitbytes/assets/helpers.dart';
import 'package:flutter/material.dart';
class AttendanceView extends StatelessWidget {
  AttendanceView({this.timeSheetData});
  final timeSheetData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Attendance View'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Start Date'),
              Card(
                child: ListTile(
                  leading: Icon(Icons.timelapse_outlined),
                  title: Text(this.timeSheetData['time_in']),
                ),
              ),

              Text('End Date'),
              Card(
                child: ListTile(
                  leading: Icon(Icons.timelapse_outlined),
                  title: Text(this.timeSheetData['time_out']),
                ),
              ),
              Text('Duration'),
              Card(
                child: ListTile(
                  leading: Icon(Icons.timer),
                  title: Text(minutesToHours(this.timeSheetData['duration'], '')),
                ),
              ),
              SizedBox(height: 30,),

              Card(
                child: timeSheetStatus(this.timeSheetData['status']),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget timeSheetStatus(status) {
    if(status == 'pending') {
      return ListTile(
        leading: Icon(Icons.check_circle),
        title: Text('Approved'),
      );
    } else {
      return ListTile(
        leading: Icon(Icons.circle_outlined),
        title: Text('Pending'),
      );
    }
  }
}
