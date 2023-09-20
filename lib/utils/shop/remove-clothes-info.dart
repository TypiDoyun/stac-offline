import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../classes/clothes.dart';

Future removeClothesInfo(String name, accessToken) async {
  try {
    await http.delete(
        Uri.parse('${dotenv.env["SERVER_URL"]}/clothes/$name'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    },);
    return null;
  // clothesData.map((clothes) => Clothes.fromJson(clothes)) as List<Clothes>;
  } catch (e) {
  rethrow;
  }
}
