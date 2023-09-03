import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../classes/clothes.dart';

Future<List<Clothes>> updateClothesInfo() async {
  try {
    final response = await http
        .get(Uri.parse('${dotenv.env["SERVER_URL"]}/clothes/location?latitude=&longitude='));
    // dynamic clothesData = json.encode(response.body);
    List<dynamic> jsonData = json.decode(response.body);
    List<Clothes> test = jsonData.map((clothes) => Clothes.fromJson(clothes)).toList();
    return test;
    // clothesData.map((clothes) => Clothes.fromJson(clothes)) as List<Clothes>;
  } catch (e) {
    rethrow;
  }
  throw Future.error("ㅎㅇ");
}
