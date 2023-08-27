import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';

import 'package:offline/userpages/login.dart';
import 'package:offline/userpages/profile.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:offline/utils/common/try-get-clothes-info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../classes/clothes.dart';
import 'userhome.dart';

//소비자 화면
class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => UserMainState();
}

class UserMainState extends State<UserMain> {
  int selectIndex = 0;
  dynamic data;
  List<Clothes>? test;

  List<double?> loca = [];
  Location location = new Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  _locateMe() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled!) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled!) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    await location.getLocation().then((res) {
      setState(() {
        loca.add(res.latitude);
        loca.add(res.longitude);
        print(loca);
      });
    });
  }

  //네이게이션바 화면 순서
  List<dynamic> bodyItem = [
    const UserHomePage(),
    const MapPage(),
    const ProfilePage(),
  ];

  List<dynamic> loginItem = [
    const UserHomePage(),
    const MapPage(),
    const LoginPage(),
  ];

  dynamic accessToken;

  String? username;
  String? id;

  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      accessToken = prefrs.getString("accessToken");
      await fetchUserData();
    })();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bodyItem.length,
      child: Scaffold(
        body: accessToken == null
            ? loginItem.elementAt(selectIndex)
            : bodyItem.elementAt(selectIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: (index) {
            setState(() {
              selectIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "MAP",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "MYPAGE",
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Future fetchUserData() async {
    SharedPreferences prefrs = await SharedPreferences.getInstance();
    String? accessToken = prefrs.getString("accessToken");
    if (accessToken == null) {
      return;
    }
    try {
      final response = await http
          .get(Uri.parse('${dotenv.env["SERVER_URL"]}/user/profile'), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $accessToken',
      });
      data = json.decode(response.body);
      await prefrs.setString('username', data["username"]);
      await prefrs.setString('id', data["id"]);
      await prefrs.setString('phoneNumber', data["phoneNumber"]);
      await prefrs.setString('birthday', data["birthday"]);
      return;
    } catch (e) {
      print("error: 토큰 만료됨");
    }
  }
}

//지도 화면
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          NaverMap(
            options: const NaverMapViewOptions(
              locationButtonEnable: true,
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
          SafeArea(
            child: Align(
              alignment: Alignment.topLeft,
              child: Container(
                margin: const EdgeInsets.all(20),
                height: 50,
                width: 120,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.add),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.remove),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.all(20),
              child: FloatingActionButton(
                elevation: 0,
                onPressed: () async {
                  await getClothesInfo(12, 21);
                },
                backgroundColor: Colors.white,
                shape: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: const Icon(
                  Icons.refresh,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
