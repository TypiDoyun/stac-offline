
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:offline/classes/clothes.dart';

Future<List<Clothes>> getClothesInfo(double a, b) async {
  try {
    final response = await http
        .get(Uri.parse('${dotenv.env["SERVER_URL"]}/clothes/location?latitude=$a&longitude=$b'));
    // dynamic clothesData = json.encode(response.body);
    List<dynamic> jsonData = json.decode(response.body);
    List<Clothes> test = jsonData.map((clothes) => Clothes.fromJson(clothes)).toList();
    print("ㅎㅇ");
    return test;
    // clothesData.map((clothes) => Clothes.fromJson(clothes)) as List<Clothes>;
  } catch (e) {
    rethrow;
  }
  throw Future.error("ㅎㅇ");
}
