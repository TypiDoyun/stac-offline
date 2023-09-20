import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future fetchShopData(String? token) async {
  SharedPreferences prefrs = await SharedPreferences.getInstance();
  String? accessToken = token;
  print("ㅎㅇ: $accessToken");
  if (accessToken == null) {
    return;
  }
  try {
    final response = await http
        .get(Uri.parse('${dotenv.env["SERVER_URL"]}/shop'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    dynamic data = json.decode(response.body);
    print("여기 $data");
    await prefrs.setString('shopname', data["name"]);
    await prefrs.setString('logo', data["logo"]);
    await prefrs.setString('address', data["address"]);
    await prefrs.setString('registrationNumber', data["registrationNumber"]);
    await prefrs.setString('shopNumber', data["shopNumber"]);
    await prefrs.setDouble('location_la', data["location"][0]);
    await prefrs.setDouble('location_lo', data["location"][1]);
    return;
  } catch (e) {
    print("error: 토큰 만료됨 $e");
  }
}