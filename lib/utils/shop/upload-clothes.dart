import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import '../../classes/clothes.dart';

Future uploadClothes(String name, comment, accessToken, int price,
    int? discountRate, List<String> size, String selectedImages) async {
  dio.Dio().options.contentType = "multipart/form-data";
  dio.Dio().options.headers['Authorization'] = 'Bearer $accessToken';

  var request = dio.Dio();

  try {
    var formData = dio.FormData.fromMap({
      "name": name,
      "price": price,
      "comment": comment,
      "discountRate": discountRate,
      "size": size,
      'images': [dio.MultipartFile.fromFileSync(selectedImages)],
    });
    var images = await request.post('${dotenv.env["SERVER_URL"]}/clothes',
        data: formData);
    // dynamic clothesData = json.encode(response.body);
    // List<dynamic> jsonData = json.decode(response.body);
    //   List<Clothes> test =
    //       jsonData.map((clothes) => Clothes.fromJson(clothes)).toList();
    //   return test;
    //   // clothesData.map((clothes) => Clothes.fromJson(clothes)) as List<Clothes>;
  } catch (e) {
    e.printError();
    rethrow;
  }
  return null;
}
