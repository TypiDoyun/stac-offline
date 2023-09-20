import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/shopinfopage.dart';

import 'package:offline/userpages/login.dart';
import 'package:offline/userpages/profile.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';
import '../utils/common/fetch-user-data.dart';
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
  double localLatitude = 0;
  double localLongitude = 0;

  List<double?> loca = [];
  List<double?> locaTest = [];
  Location location = Location();
  bool? _serviceEnabled;
  PermissionStatus? _permissionGranted;

  Future _locateMe() async {
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
      loca.add(res.latitude);
      loca.add(res.longitude);
      localLatitude = loca[0]!;
      localLongitude = loca[1]!;

      SharedPreferences prefrs = await SharedPreferences.getInstance();
      await prefrs.setDouble("latitude", localLatitude);
      await prefrs.setDouble("longitude", localLongitude);
    });
  }

  //네이게이션바 화면 순서
  List<Widget> bodyItem = [
    const UserHomePage(),
    const MapPage(),
    const ProfilePage(),
  ];

  List<Widget> loginItem = [
    const UserHomePage(),
    const MapPage(),
    const LoginPage(),
  ];

  dynamic accessToken;
  bool? isMerchant;

  String? username;
  String? id;

  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      isMerchant = prefrs.getBool("isMerchant");
      print(isMerchant);
      accessToken = prefrs.getString("accessToken");
      await fetchUserData(prefrs.getString("accessToken"));
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
        appBar:AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          shadowColor: Colors.transparent,
          title: const Text("Offline"),
          titleTextStyle: TextStyle(
            fontFamily: "GmarketSansKR",
            color: Theme.of(context).colorScheme.secondary,
            fontSize: size.height * 0.03,
            letterSpacing: size.width * -0.004,
            fontWeight: FontWeight.normal,
          ),
          centerTitle: true,
        ),
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
          selectedItemColor: Theme.of(context).colorScheme.tertiaryContainer,
          selectedFontSize: size.height * 0.013,
          selectedIconTheme: IconThemeData(size: size.height * 0.03),
          unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
          unselectedFontSize: size.height * 0.011,
          unselectedIconTheme: IconThemeData(size: size.height * 0.03),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

class ShopInfo {
  final String id;
  final double latitude;
  final double longitude;

  ShopInfo({required this.id, required this.latitude, required this.longitude});
}

//맵
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Future<void>? dataLoading;


  NMarker? userMaker;

  List<ShopInfo> shopInfos = [
    ShopInfo(id: 'shop1', latitude: 37.1253841, longitude: 127.2159064),
    ShopInfo(id: 'shop2', latitude: 37.1253251, longitude: 127.2164626),
    ShopInfo(id: 'shop3', latitude: 37.1253461, longitude: 127.2184676),
    // Add more shop info here...
  ];

  List<NMarker> markers = [];
  NLatLng? userLoca;
  NPoint? userMarkerNPoint = const NPoint(0.5, 0.5);

  @override
  void initState() {
    super.initState();
    dataLoading = getLocation();
  }

  Future<void> getLocation() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    double? latitude = prefs.getDouble("latitude");
    double? longitude = prefs.getDouble("longitude");


    if (latitude != null && longitude != null) {
      setState(() {
        userLoca = NLatLng(latitude, longitude);

        userMaker = NMarker(
          isCaptionPerspectiveEnabled: true,
          anchor: userMarkerNPoint!,
          icon: const NOverlayImage.fromAssetImage(
              "assets/images/userLocationIcon.png"),
          size: const Size(30, 30),
          caption: const NOverlayCaption(text: "현위치"),
          id: 'test',
          position: NLatLng(latitude, longitude),
        );
        markers = shopInfos.map((shopInfo) {
          return NMarker(
            id: shopInfo.id,
            position: NLatLng(shopInfo.latitude, shopInfo.longitude),
            iconTintColor: Colors.red,
          );
        }).toList();

        // 각 마커에 onTapListener 추가
        for (NMarker marker in markers) {
          marker.setOnTapListener((overlay) {
            // 마커를 탭했을 때 실행할 동작을 여기에 작성합니다.
            // overlay 변수는 탭된 마커를 나타냅니다.
            // 가게 정보를 포함하는 하단 시트를 표시합니다.
            Get.to(
                  () => const ShopInfoPage(),
              transition: Transition.downToUp,
            );
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: dataLoading,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // 데이터가 아직 오지 않은 상태면 로딩 표시
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("연결 중입니다."),
                SizedBox(
                  height: 20,
                ),
                CircularProgressIndicator(
                  strokeAlign: BorderSide.strokeAlignCenter,
                ),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          // 데이터가 오면 UI를 구성
          return Scaffold(
            body: Stack(
              alignment: Alignment.center,
              children: [
                NaverMap(
                  options: NaverMapViewOptions(
                    locationButtonEnable: true,
                    initialCameraPosition: NCameraPosition(
                      target: userLoca ?? const NLatLng(33.33, 127.2164625),
                      zoom: 15,
                      bearing: 0,
                      tilt: 0,
                    ),
                  ),
                  onMapReady: (controller) {
                    controller.addOverlay(userMaker!);
                    if (markers.isNotEmpty) {
                      controller.addOverlayAll(Set<NMarker>.from(markers));
                    }
                    print("네이버 맵 로딩됨!");
                  },
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
