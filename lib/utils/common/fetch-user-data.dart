import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future fetchUserData(String? token) async {
  SharedPreferences prefrs = await SharedPreferences.getInstance();
  String? accessToken = token;
  if (accessToken == null) {
    return;
  }
  try {
    final response = await http
        .get(Uri.parse('${dotenv.env["SERVER_URL"]}/user/profile'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    dynamic data = json.decode(response.body);
    print(data);
    await prefrs.setString('username', data["username"]);
    await prefrs.setString('id', data["id"]);
    await prefrs.setString('phoneNumber', data["phoneNumber"]);
    await prefrs.setString('birthday', data["birthday"]);
    return;
  } catch (e) {
    print("error: 토큰 만료됨");
  }
}