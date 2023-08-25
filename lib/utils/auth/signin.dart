import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';



Future signIn(String id, String password) async {
  SharedPreferences prefrs = await SharedPreferences.getInstance();
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env["SERVER_URL"]}/auth/signin'), // 서버의 엔드포인트 URL로 변경
      body: {
        'id': id,
        'password': password,
      },
    );
    dynamic tokens = json.decode(response.body);
    if (tokens["statusCode"] == 401) return false;

    String createdAccessToken = tokens["accessToken"];
    String createdRefreshToken = tokens["refreshToken"];

    await prefrs.setString("accessToken", createdAccessToken);
    await prefrs.setString("refreshToken", createdRefreshToken);
    return true;
  } catch (e){
    return false;
  }
}