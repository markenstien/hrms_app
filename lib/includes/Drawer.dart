import 'package:bitbytes/assets/constants.dart';
import 'package:bitbytes/pages/AttendancePage.dart';
import 'package:bitbytes/pages/AttendanceQRPage.dart';
import 'package:bitbytes/pages/LoginPage.dart';
import 'package:bitbytes/pages/Payslip.dart';
import 'package:bitbytes/pages/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          Container(
            height: 150.0,
            width: 190.0,
            padding: const EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(200),
            ),
            child: Center(
              child: InkWell(
                child: Image.network(PROFILE_PICTURE_LINK),
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage()));
                },
              ),
            ),
          ),

          ListTile(
            leading: Icon(Icons.timer),
            title: const Text('Attendance'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => AttendaceMainPage()));
            },
          ),

          ListTile(
            leading: Icon(Icons.lock_clock),
            title: const Text('File Attendance'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => AttendanceQRPage()));
            },
          ),

          ListTile(
            leading: Icon(Icons.payment),
            title: const Text('Payslip'),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => Payslip()));
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: const Text('Logout'),
            onTap: () async{
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.remove('authUser');
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginPage()));
            },
          )
        ],
      ),
    );
  }
}
