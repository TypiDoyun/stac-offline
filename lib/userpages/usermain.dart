import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

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
  dynamic localLatitude;
  dynamic localLongitude;



  List<double?> loca = [];
  Location location = Location();
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
    await location.getLocation().then((res) async {
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      setState(() {
        loca.add(res.latitude);
        loca.add(res.longitude);
        prefrs.setDouble("latitude", loca[0]!);
        prefrs.setDouble("longitude", loca[1]!);
        print('location: $loca');
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
      print(localLatitude);
      await fetchUserData();
      await _locateMe();
        //   Get.dialog(
        //   (AlertDialog(
        //     title: const Text("어디 계신가요?"),
        //     content: Text("위치확인을 허용해주시면 동네 옷들을 보여드릴게요"),
        //     actions: [
        //       TextButton(
        //           child: const Text("아니요"), onPressed: () async {}),
        //       TextButton(
        //         child: const Text("네"),
        //         onPressed: () async {
        //           Get.back();
        //           print("ㅎㅇ");
        //           // await _locateMe();
        //         },
        //       ),
        //     ],
        //   )),
        // );
    })();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
          items: [
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
          selectedItemColor: Theme.of(context).colorScheme.onTertiaryContainer,
          selectedFontSize: size.height * 0.015,
          selectedIconTheme: IconThemeData(size: size.height * 0.03),
          unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
          unselectedFontSize: size.height * 0.015,
          unselectedIconTheme: IconThemeData(size: size.height * 0.03),
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

  List<double?> loca = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      loca[0] = prefrs.getDouble("latitude");
      loca[1] = prefrs.getDouble("longitude");
      print("ㅎㅇ");
      loading = false;
    }());
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          NaverMap(
            options: NaverMapViewOptions(
              locationButtonEnable: true,
              initialCameraPosition: NCameraPosition(
                target: NLatLng(loca[0]!, loca[1]!),
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
