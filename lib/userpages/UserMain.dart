import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'LoginPage.dart';
import 'UserHomePage.dart';


//소비자 화면
class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => UserMainState();
}

class UserMainState extends State<UserMain> {
  int select_index = 0;

  //네이게이션바 화면 순서
  List<dynamic> body_item = [
    const UserHomePage(),
    const MapPage(),
    const LoginPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: body_item.length,
        child: Scaffold(
          body: body_item.elementAt(select_index),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: select_index,
            onTap: (index) {
              setState(() {
                select_index =   index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: "HOME"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.location_on), label: "MAP"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.person), label: "LOGIN"),
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
    return const Scaffold(
      body: NaverMap(),
    );
  }
}