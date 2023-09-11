import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'Widgets/User.dart';

const String serverData = '';
const String serverUrl_1 = 'http://11.187.12.81:3000';
const String serverUrl_2 = 'http://117.110.121.213:3000';

bool? checkId;

Future<void> getUserFromServer(String data) async {
  try {
    final response = await http.get(
      Uri.parse('$serverUrl_2/user/profile'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $data',
        }
    );
    Map userProfile = json.decode(response.body);
    print('gd');
    print(userProfile);
  }
  catch (e) {
    print(e);
  }
}

String _decodeBase64(String str) {
  String output = str.replaceAll('-', '+').replaceAll('_', '/');

  switch (output.length % 4) {
    case 0:
      break;
    case 2:
      output += '==';
      break;
    case 3:
      output += '=';
      break;
    default:
      throw Exception('Illegal base64url string!"');
  }

  return utf8.decode(base64Url.decode(output));
}

Map<String, dynamic> parseJwtPayLoad(String token) {
  final parts = token.split('.');
  if (parts.length != 3) {
    throw Exception('invalid token');
  }

  final payload = _decodeBase64(parts[1]);
  final payloadMap = json.decode(payload);
  if (payloadMap is! Map<String, dynamic>) {
    throw Exception('invalid payload');
  }

  return payloadMap;
}
//
// Future getClothesInfo(Clothes data) async {
//   try {
//     final response = await http.get(
//       Uri.parse('$serverUrl_2/'),
//       headers: {
//
//       }
//     );
//   // Clothes clothesinfo  = Clothes.fromJson(json.decode(response.body));
//   // print(clothesinfo);
//   } catch (e) {
//     print('error: $e');
//   }
// }


Future<void> sendUserInfoDataToServer(User data) async {
  try {
    final response = await http.post(
      Uri.parse('${dotenv.env["SERVER_URL"]}/auth/signup'), // 서버의 엔드포인트 URL로 변경
      body: {
        'username': data.username,
        'id': data.id,
        'password': data.password,
        'phoneNumber': data.phoneNumber,
        'birthday': data.birthday,
      },
    );
    if (response.statusCode == 201) {
      print('Data sent successfully!');

    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
      print('Failed to send data. Error code: ${json.encode(response.body)}');
    }
  } catch (e) {
    print('Error while sending data: $e');
  }
}

  Future<String> fetchDataFromServer() async {
    try {
      final response = await http.get(
        Uri.parse('$serverUrl_2/data'), // 서버의 엔드포인트 URL로 변경
      );
      if (response.statusCode == 200) {
        final fetchedData = response.body; // 서버에서 가져온 데이터
        print('Data fetched successfully: $fetchedData');
        return fetchedData; // 데이터 반환
      } else {
        print('Failed to fetch data. Error code: ${response.statusCode}');
        return ''; // 빈 문자열 반환 또는 에러 처리
      }
    } catch (e) {
      print('Error while fetching data: $e');
      return ''; // 빈 문자열 반환 또는 에러 처리
    }
  }