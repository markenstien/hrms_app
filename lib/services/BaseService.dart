import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BaseService {
  static const baseURL = 'https://bitmates.site/api';

  Future get(String url) async {
    final response = await http.get(Uri.parse("$baseURL/$url"));
    if(response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String,dynamic>;
      return responseData;
    } else {
      throw Exception('someting went wrong');
    }
  }


  Future post(String url, Map<String, dynamic> body) async{
    final response = await http.post(
      Uri.parse("$baseURL/$url"),
      body: body,
    );

    if(response.statusCode == 200) {
      final responseData = jsonDecode(response.body) as Map<String, dynamic>;
      return responseData;
    } else {
      throw Exception('something went wrong');
    }
  }
}
