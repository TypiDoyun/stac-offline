import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../../servercontroller.dart';

Future authShop(String registrationNumber, representative, openingDate) async {
  try {
    final response = await http.get(
      Uri.parse(
          '${dotenv.env["SERVER_URL"]}/auth/validate?registrationNumber=$registrationNumber&representative=$representative&openingDate=$openingDate'),
      // 서버의 엔드포인트 URL로 변경
    );
    if (response.statusCode == 200) {
      print('Data sent successfully! ${response.body}');
      return response.body == "true" ? true : false;
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
