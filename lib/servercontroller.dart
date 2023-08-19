import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:offline/userpages/userhome.dart';
import 'package:offline/userpages/usermain.dart';
import 'package:offline/userpages/userpref.dart';
import 'Widgets/user.dart';

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
    User userProfile = User.fromJson(json.decode(response.body));
    print(userProfile.username);
  }

  catch (e) {
    print(e);
  };
}

Future<void> sendUserInfoDataToServer(Map data) async {
  try {
    final response = await http.post(
      Uri.parse('$serverUrl_2/auth/signup'), // 서버의 엔드포인트 URL로 변경
      body: {
        'username': data['userName'],
        'id': data['userId'],
        'password': data['userPassword'],
        'phoneNumber': data['userPhonenumber'],
        'birthday': data['userBirth'],
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


Future sendUserLoginToServer(Map data) async {
  try {
    final response = await http.post(
      Uri.parse('$serverUrl_2/auth/signin'), // 서버의 엔드포인트 URL로 변경
      body: {
        'id': data['userId'],
        'password': data['userPassword'],
      },
    );
    if (response.statusCode == 201) {
      dynamic data = json.decode(response.body);
      print('Data sent successfully! ');
      print("jwt token is ${data["accessToken"]}");
      await RememberToken.saveRememberToken(data["accessToken"]);
      print("gd");
      Get.to(const UserMain());
      return data["accessToken"];

      // User userInfo  = User.fromJson(userToken);

      // User userInfo = User.fromJson(data["token"]);
      //
      // await RememberUser.saveRememberUserInfo(userInfo);
      //
      // Get.to(const UserHomePage());
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
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