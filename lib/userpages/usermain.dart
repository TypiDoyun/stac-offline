import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:offline/userpages/profile.dart';
import 'package:offline/utils/auth/is-refresh-token-valid.dart';
import 'package:offline/utils/auth/try-refresh-access-token.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'login.dart';
import 'userhome.dart';


//소비자 화면
class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => UserMainState();
}

class UserMainState extends State<UserMain> {
  dynamic data = null;

  int select_index = 0;

  //네이게이션바 화면 순서
  List<dynamic> body_item = [
    const UserHomePage(),
    const MapPage(),
    const ProfilePage(),
  ];

  bool? isValid;
  @override
  initState() {
    super.initState();
    (() async {
      isValid = await isRefreshTokenValid();
    })();
  }

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
        length: body_item.length,
        child: Scaffold(
          body: body_item.elementAt(select_index),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: select_index,
            onTap: (index) async {
              if (index == 2) { // MYPAGE 아이템이 눌렸을 때
                if (isValid!) {
                  print('1: $isValid}');
                  setState(() {
                    select_index = index;
                  });
                } else {
                  print('2: $isValid}');
                  Navigator.pushReplacement( // 로그인 페이지로 이동
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                }
              } else {
                print('3: $isValid}');
                setState(() {
                  select_index = index;
                });
              }
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "HOME"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on), label: "MAP"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "MYPAGE"),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
        )
    );
  }
}

//지도 화면
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NaverMap(
        options: const NaverMapViewOptions(
          initialCameraPosition: NCameraPosition(
              target: NLatLng(37.532600, 127.024612),
              zoom: 10,
              bearing: 0,
              tilt: 0,
          ),
        ),
        onMapReady: (controller) {
          print("네이버 맵 로딩됨!");
        },
      ),
    );
  }
}

