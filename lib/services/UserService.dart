import 'dart:convert';

import 'package:bitbytes/services/BaseService.dart';
class UserService extends BaseService {

  Future authenticate (secret,key) async {
    if(secret == '' || key == '') {
      return false;
    }
    var response = await post('/user/authenticate', {
      'email' : secret,
      'password' : key
    });

    return response;
  }

  String stringifyUserData(Map<String,dynamic> userData) {
    return jsonEncode(userData);
  }

  Future getUser() async {
    return await get('user/getById/?id=1');
  }

}
