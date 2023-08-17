import 'dart:convert';

import 'package:http/http.dart' as http;

final String serverData = '';
final String serverUrl = 'http://192.168.2.59:3000';


Future<void> sendUserInfoDataToServer(Map data) async {
  try {
    final response = await http.post(
      Uri.parse('$serverUrl/users'), // 서버의 엔드포인트 URL로 변경
      body: {
        'userName': data['userName'],
        'userId': data['userId'],
        'userPassword': data['userPassword'],
        'userPhonenumber': (data['userPhonenumber']).toString(),
        'userBirth': data['userBirth'].toString(),
      },
    );
    if (response.statusCode == 201) {
      print('Data sent successfully!');
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error while sending data: $e');
  }
}


Future<void> sendUserLoginToServer(Map data) async {
  try {
    final response = await http.post(
      Uri.parse('$serverUrl/users/login'), // 서버의 엔드포인트 URL로 변경
      body: {
        'userId': data['userId'],
        'userPassword': data['userPassword'],
      },
    );
    if (response.statusCode == 201) {
      dynamic data = json.decode(response.body);
      print('Data sent successfully! ');
      print("jwt token is ${data["token"]}");
    } else {
      print('Failed to send data. Error code: ${response.statusCode}');
    }
  } catch (e) {
    print('Error while sending data: $e');
  }
}

Future<void> checkUserId(Map data) async {
  try {
    final response = await http.post(
      Uri.parse('$serverUrl/users/login'), // 서버의 엔드포인트 URL로 변경
      body: {
        'userId': data['userId'],
      },
    );
    if (response.statusCode == 201) {
      dynamic data=  json.decode(response.body);
      print("jwt token is ${data["token"]}");
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
      Uri.parse('$serverUrl/data'), // 서버의 엔드포인트 URL로 변경
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

