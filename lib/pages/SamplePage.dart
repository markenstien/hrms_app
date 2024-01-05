import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class SamplePage extends StatefulWidget {
  const SamplePage({Key? key}) : super(key: key);

  @override
  State<SamplePage> createState() => _SamplePageState();
}

class _SamplePageState extends State<SamplePage> {
  void getUserdata () async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var authUser = prefs.getString('authUser');
    print(authUser);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('test'),
      ),
      body: Center(
        child: Column(
          children: [
            InkWell(
              onTap: () async {
                getUserdata();
              },
              child: Card(
                child: Text('Test Shared Preferences'),
              ),
            )

          ],
        ),
      ),
    );
  }
}
