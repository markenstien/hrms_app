import 'package:bitbytes/assets/constants.dart';
import 'package:bitbytes/pages/ProfilePage.dart';
import 'package:bitbytes/pages/SamplePage.dart';
import 'package:bitbytes/services/UserService.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final keyController = TextEditingController();
  final secretController = TextEditingController();

  UserService userService = UserService();
  String userData = '';
  String message = '';
  bool isMessageShow = false;

  void setUserdata(userDataString) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('authUser', userDataString);
  }
  @override
  void dispose() {
    keyController.dispose();
    secretController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Welcome to ${COMPANY_NAME}'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(BODY_PADDING),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
              const SizedBox(height: 30,),
              TextField(
                controller: keyController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                    hintText: 'Enter Email'
                ),
              ),
              const SizedBox(height: 12,),
              TextField(
                controller: secretController,
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Password'
                ),
              ),

              if(isMessageShow)
                Text('$message')
              else
                Text('$message'),
              const SizedBox(height: 30,),
              ElevatedButton(onPressed: () async {
                var response = await userService.authenticate(keyController.text,secretController.text).then((response){
                  if(response['success'] == true) {
                    setUserdata(userService.stringifyUserData(response['user']));
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ProfilePage()));
                    setState(() {
                      message = '';
                      isMessageShow = false;
                    });
                  } else {
                    setState(() {
                      message = response['message'];
                      isMessageShow = true;
                    });
                  }
                }).catchError((response) {
                  setState(() {
                    message = 'Invalid Login';
                    isMessageShow = true;
                  });
                });

              },
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50)
                ),
                child: const Text('Login'),)
            ],
          ),
        ),
      ),
    );
  }
}
