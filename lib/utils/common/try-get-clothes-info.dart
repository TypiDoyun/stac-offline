
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:http/http.dart' as http;
import 'package:offline/classes/clothes.dart';

Future getClothesInfo(String a, b) async {
  try {
    final response = await http
        .get(Uri.parse('${dotenv.env["SERVER_URL"]}/clothes?a=$a&b=$b'));
    dynamic clothesData = json.encode(response.body);
    List<Clothes> clothes = clothesData.map((clothes) => Clothes.fromJson(clothes)) as List<Clothes>;


  } catch (e) {
    print('error: $e');
  }
}
