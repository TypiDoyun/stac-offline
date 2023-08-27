import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

Future getOwnerInfo(String registrationNumber, representative, openingDate) async {
  try {
    final response = await http
        .get(Uri.parse('${dotenv.env["SERVER_URL"]}/auth/validate?registrationNumber=$registrationNumber&representative=$representative&openingDate=$openingDate'));
    // dynamic clothesData = json.encode(response.body);
    print(response.body);
    // clothesData.map((clothes) => Clothes.fromJson(clothes)) as List<Clothes>;
  } catch (e) {
    print('error: $e');
  }
}
