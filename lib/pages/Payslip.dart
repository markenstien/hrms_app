import 'dart:convert';

import 'package:bitbytes/pages/PayslipView.dart';
import 'package:bitbytes/services/AttendanceService.dart';
import 'package:bitbytes/services/PayslipService.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payslip extends StatefulWidget {
  const Payslip({Key? key}) : super(key: key);

  @override
  State<Payslip> createState() => _PayslipState();
}

class _PayslipState extends State<Payslip> {
  PayslipService payslipService = PayslipService();
  var userData = {};
  var attendanceList = [];

  Future fetchPayslip() async{
    var response = await payslipService.getList(userData['id']);
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
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payslip'),
      ),
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
          itemCount: projectSnap.data.length,
          itemBuilder: (context, index) {
            var payslipRow = projectSnap.data[index];

            return ListTile(
              leading: Icon(Icons.timelapse_outlined),
              title: Text("${payslipRow['start_date']} to ${payslipRow['end_date']}"),
              trailing: Icon(Icons.calendar_month),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => PayslipView(
                  userData: userData,
                  payslipData: payslipRow,
                )));
              },
            );
          },
        );
      },
      future: fetchPayslip(),
    );
  }
}
