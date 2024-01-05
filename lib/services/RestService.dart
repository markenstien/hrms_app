import 'dart:convert';

import 'package:http/http.dart' as http;

class RestService {
  static const URL = 'https://bitmates.site/api';
  static Future get(String endpoint) async {
    var response = await http.get(Uri.parse("$URL/$endpoint"));
    return jsonDecode(response.body);
  }

  static Future getRaw(String endpoint) async {
    var response = await http.get(Uri.parse(endpoint));
    return jsonDecode(response.body);
  }

  static Future<Map> post(String endpoint, Map<String, dynamic> params) async {
    var response = await http.post(
      Uri.parse("$URL/$endpoint"),
      body: params,
    );
    return jsonDecode(response.body);
  }
}
