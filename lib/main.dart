import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:offline/servercontroller.dart';
import 'package:offline/utils/auth/try-refresh-access-token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'userpages/usermain.dart';

//black을 MaterialColor로 변경
const MaterialColor primaryBlack =
    MaterialColor(_blackPrimaryValue, <int, Color>{
  50: Color(0xFF000000),
  100: Color(0xFF000000),
  200: Color(0xFF000000),
  300: Color(0xFF000000),
  400: Color(0xFF000000),
  500: Color(_blackPrimaryValue),
  600: Color(0xFF000000),
  700: Color(0xFF000000),
  800: Color(0xFF000000),
  900: Color(0xFF000000),
});

const int _blackPrimaryValue = 0xFF000000;

dynamic data = false;

void main() async {
  await dotenv.load(fileName: "assets/config/.env");
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: '1iqz7k390v');
  await tryRefreshAccessToken();
  await fetchUserData();
  print(data);

  return runApp(GestureDetector(
    onTap: () {
      FocusManager.instance.primaryFocus?.unfocus();
    },
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: const UserMain(),
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primarySwatch: primaryBlack,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          )),
    ),
  ));
}

Future fetchUserData() async {
  SharedPreferences prefrs = await SharedPreferences.getInstance();
  String? accessToken = prefrs.getString("accessToken");
  try {
    final response = await http
        .get(Uri.parse('${dotenv.env["SERVER_URL"]}/user/profile'), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $accessToken',
    });
    print(response.body);
    data = json.decode(response.body);
    await prefrs.setString('username', data["username"]);
  } catch (e) {
    print("error: 토큰 만료됨");
  }

}
