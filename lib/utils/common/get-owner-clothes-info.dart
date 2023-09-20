import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:offline/classes/clothes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

Future<List<Clothes>> getOwnerClothesInfo(String? token) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = token;
  if (accessToken == null) {
    return []; // 토큰이 없을 경우 빈 리스트 반환
  }

  try {
    final response = await http.get(Uri.parse('${dotenv.env["SERVER_URL"]}/clothes/own'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    dynamic data = json.decode(response.body);
    List<Clothes> clothesList = [];
    // data 배열을 순회하면서 Clothes 객체를 생성하고 리스트에 추가
    for (var item in data) {
      Clothes clothes = Clothes.fromJson(item);
      clothesList.add(clothes);
    }
    return clothesList;
  } catch (e) {
    print("error: 토큰 만료됨 $e");
    return [];
  }
}

