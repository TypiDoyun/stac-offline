import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:offline/utils/auth/try-refresh-access-token.dart';
import 'theme/light-theme.dart';
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
  // 앱 실행 시 한번만 실행
  await dotenv.load(fileName: "assets/config/.env"); // <- IP주소
  WidgetsFlutterBinding.ensureInitialized(); // <-네이버 지도 API
  await NaverMapSdk.instance.initialize(clientId: '1iqz7k390v'); // <-네이버 지도 API
  await tryRefreshAccessToken(); // <-로컬 저장소에 있는 엑세스토큰의 유효기간 확인

  return runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus(); // <-화면 터치 시 키보드 해제
      },
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const UserMain(),
        theme: lightTheme,
      ),
    );
  }
}
