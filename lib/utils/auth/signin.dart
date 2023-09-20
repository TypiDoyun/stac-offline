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
    print(tokens);
    if (tokens["statusCode"] == 400 || tokens["statusCode"] == 403) return "error";

    String createdAccessToken = tokens["accessToken"];
    String createdRefreshToken = tokens["refreshToken"];
    bool isMerchant = tokens["isMerchant"];

    await prefrs.setString("accessToken", createdAccessToken);
    print(createdRefreshToken);
    await prefrs.setString("refreshToken", createdRefreshToken);
    await prefrs.setBool("isMerchant", isMerchant);
    return isMerchant;
  } catch (e){
    return false;
  }
}
