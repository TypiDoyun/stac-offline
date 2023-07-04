import 'package:flutter/material.dart';
import 'package:offline/AlarmPage.dart';
import 'package:offline/MainPage.dart';
import 'package:offline/MapPage.dart';
import 'package:offline/UserPage.dart';

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
  List<dynamic> body_item = [
    const MainPage(),
    const MapPage(),
    UserPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: body_item.length,
        child: Scaffold(
          body: SafeArea(
            child: body_item.elementAt(current_index),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: current_index,
            onTap: (index) {
              setState(() {
                current_index = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.line_weight), label: "메인"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined), label: "지도"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline), label: "내정보"),
            ],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.grey,
            type: BottomNavigationBarType.fixed,
          ),
        ));
  }
}