import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

final String serverUrl = 'http://117.110.121.213:3000';
final String serverData = '';

Future<void> sendUserInfoDataToServer(Map data) async {
  try {
    final response = await http.post(
      Uri.parse('$serverUrl/'), // 서버의 엔드포인트 URL로 변경
      body: {'userName': data['userName'],
        'userId': data['userId'],
        'userPassword': data['userPassword'],
        'userPhonenumber': data['userPhonenumber'],
        'userBirth': data['userBirth'],
        'userLocation': data['userLocation'],
      },
    );
    if (response.statusCode == 200) {
      print('Data sent successfully!');
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

