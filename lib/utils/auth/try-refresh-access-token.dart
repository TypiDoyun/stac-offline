import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../servercontroller.dart';

tryRefreshAccessToken() async {
  SharedPreferences prefrs = await SharedPreferences.getInstance();
  String? accessToken = prefrs.getString('accessToken');
  print("refresh");

  if (accessToken == null) return;
  dynamic accessPayload = parseJwtPayLoad(accessToken);

  int now = DateTime.now().millisecondsSinceEpoch;

  int expirationTime = accessPayload["exp"] * 1000;
  if (expirationTime - 5000 > now) return; //<-여기에서 끝나면 유효한거지?


  String? refreshToken = await prefrs.getString('refreshToken');
  if (refreshToken == null) return;

  try {
    final response = await http.post(Uri.parse('${dotenv.env["SERVER_URL"]}/auth/refresh'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $refreshToken',
    });
    print(response.body);
    dynamic tokens = json.decode(response.body);
    dynamic createdAccessToken = tokens["accessToken"];
    String createdRefreshToken = tokens["refreshToken"];
    await prefrs.setString("accessToken", createdAccessToken);
    await prefrs.setString("refreshToken", createdRefreshToken);

    return true;
  } catch (e){
      print("error: $e");
  }
}
//로컬 저장소에 저장된 accessToken을 확인한다.
//
//accessToken이 null이 아닌지 확인하고, null이라면 함수를 종료한다.
//
//paeseJwtPayload함수를 이용하여 accessToken을 payload로 복호화한다.
//
//복호화된 payload 객체 속 만료 시간을 의미하는 exp를 현재 시간과 비교하여 만료 여부를 확인한다.
//
//만약 만료가 되지 않았다면 함수를 종료한다.
//
//만약 만료가 되었다면 ip:3000/auth/refresh 주소로 refreshToken과 함께 post 요청을 보낸다. (토큰 전송 방식은 Bearer)
//
//서버가 응답한 새로운 accessToken과 refreshToken을 로컬에 저장하고 함수를 종료한다.