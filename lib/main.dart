import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NaverMapSdk.instance.initialize(clientId: '1iqz7k390v');

  return runApp(
    GestureDetector(
      onTap: (){
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
          )
        ),
      ),
    )
  );
}


