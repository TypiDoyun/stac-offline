import 'package:flutter/material.dart';
import 'package:offline/AlarmPage.dart';
import 'package:offline/MainPage.dart';
import 'package:offline/MapPage.dart';
import 'package:offline/SettingPage.dart';
import 'package:offline/UserPage.dart';
import 'package:offline/Widgets/LikeItem.dart';

void main() {
  return runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyTest();
}

class MyTest extends State<MyApp> {
  int current_index = 0;

  //네이게이션바 화면 순서
  List body_item = [
    UserPage(),
    LikeItem(),
    const MainPage(),
    const AlarmPage(),
    SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5,
        child: Scaffold(
          appBar: AppBar(
              backgroundColor: const Color(0xffeeeeee),
              elevation: 0,
              title: const TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                  ),
                  hintText: '검색어를 입력해주세요!',
                  suffixIcon: Icon(Icons.search), // 돋보기 아이콘을 추가합니다.
                ),
              )
          ),
          body: body_item.elementAt(current_index),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: current_index,
            onTap: (index) {
              setState(() {
                current_index = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: '내정보'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_outline), label: '찜하기'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined), label: '지도'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.notifications_outlined), label: '알람'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined), label: '설정'),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}