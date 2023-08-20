import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../Widgets/Clothes.dart';
import 'package:http/http.dart' as http;

Future getClothesInfo(Clothes data) async {
  try {
    final response = await http.get(
        Uri.parse('${dotenv.env["SERVER_URL"]}/??'), //아하!
        headers: {
          "_id" : data.id,
        }
    );
    // Clothes clothesinfo  = Clothes.fromJson(json.decode(response.body));
    // print(clothesinfo);
  } catch (e) {
    print('error: $e');
  }
}