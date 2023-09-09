import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image/image.dart';
import 'package:offline/classes/merchant.dart';
import 'package:offline/ownerpages/shopinfopage.dart';

import 'package:offline/userpages/login.dart';
import 'package:offline/userpages/profile.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;
import 'package:offline/utils/common/try-get-clothes-info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../classes/clothes.dart';
import '../classes/shop.dart';
import '../utils/auth/try-refresh-access-token.dart';
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
  List<double?> locaTest = [];
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
      loca.add(res.latitude);
      loca.add(res.longitude);
      print(loca);
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      prefrs.setDouble("latitude", loca[0]!);
      prefrs.setDouble("longitude", loca[1]!);

    });

    // saveLocation() async {
    //
    // }
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

  String? username;
  String? id;


  @override
  void initState() {
    super.initState();
    (() async {
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      print(localLatitude);
      print("여기 ${prefrs.getString("accessToken")}");
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
    Size size = MediaQuery
        .of(context)
        .size;
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
              print(index);
              selectIndex = index;
            });
          },
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "HOME",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "MAP",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "MYPAGE",
            ),
          ],
          selectedItemColor: Theme
              .of(context)
              .colorScheme
              .onTertiaryContainer,
          selectedFontSize: size.height * 0.015,
          selectedIconTheme: IconThemeData(size: size.height * 0.03),
          unselectedItemColor: Theme
              .of(context)
              .colorScheme
              .onSecondary,
          unselectedFontSize: size.height * 0.015,
          unselectedIconTheme: IconThemeData(size: size.height * 0.03),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Future fetchUserData(String? token) async {
    SharedPreferences prefrs = await SharedPreferences.getInstance();
    String? accessToken = token;
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


//맵
class MapPage extends StatefulWidget {
  const MapPage({Key? key}) : super(key: key);

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  Future<void>? dataLoading;
  NMarker? marker1, marker2;
  NLatLng? userLoca;
  NPoint? userMarkerNPoint = NPoint(0.5,0.5);


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

        marker1 = NMarker(
          captionOffset: 10,
          captionAligns: [NAlign.left],
          subCaption: NOverlayCaption(text: "현위치 입니다."),
          isCaptionPerspectiveEnabled: true,
          anchor: userMarkerNPoint!,
          icon: NOverlayImage.fromAssetImage("assets/images/test.png"),

          size: Size(50, 50),
          caption: NOverlayCaption(text: "현위치"),
          id: 'test',
          position: NLatLng(latitude, longitude),
        );
        marker2 = NMarker(id: "test2", position: NLatLng(latitude,longitude),iconTintColor: Colors.red);
      });
    } else {
      // Handle the case where latitude or longitude is not available in SharedPreferences.
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
                      target: userLoca ?? NLatLng(33.33, 127.2164625),
                      zoom: 15,
                      bearing: 0,
                      tilt: 0,
                    ),
                  ),
                  onMapReady: (controller) {
                    if (marker1 != null) {
                      controller.addOverlay(marker1!);
                    }
                    if (marker2 != null) {
                      controller.addOverlay(marker2!);
                    }
                    print("네이버 맵 로딩됨!");
                    marker2?.setOnTapListener((overlay) => Get.to(() => ShopInfoPage(shopInfo: null, shopInfos: null)));
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



//지도 화면
// class MapPage extends StatefulWidget {
//   const MapPage({Key? key}) : super(key: key);
//
//   @override
//   State<MapPage> createState() => MapPageState();
// }
//
//
// class MapPageState extends State<MapPage> {
//
//   Future<void>? dataLoading;
//   랴ㅜㅁㄱ
//
//   @override
//   void initState() {
//     super.initState();
//     (() async {
//       List<double?> location = await getLocation();
//
//       if (location[0] != null && location[1] != null) {
//         final marker = NMarker(
//           icon: const NOverlayImage.fromAssetImage('assets/images/test.png'),
//           id: 'test',
//           position: NLatLng(location[0]!, location[1]!),
//         );
//
//         // Use the marker as needed.
//       } else {
//         // Handle the case where latitude or longitude is not available.
//       }
//     }());
//     setState(() {});
//   }
//
//   Future<List<double?>> getLocation() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     double? latitude = prefs.getDouble("latitude");
//     double? longitude = prefs.getDouble("longitude");
//
//     if (latitude != null && longitude != null) {
//       return [latitude, longitude];
//     } else {
//       // Handle the case where latitude or longitude is not available in SharedPreferences.
//       return [null, null];
//     }
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//
//
//     return FutureBuilder<void>(
//       future: dataLoading,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           // 데이터가 아직 오지 않은 상태면 로딩 표시
//           return const Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text("연결 중입니다."),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 CircularProgressIndicator(
//                   strokeAlign: BorderSide.strokeAlignCenter,
//                 ),
//               ],
//             ),
//           );
//         } else if (snapshot.hasError) {
//           return Center(child: Text('Error: ${snapshot.error}'));
//         } else {
//           // 데이터가 오면 UI를 구성
//           return Scaffold(
//             body: Stack(
//               alignment: Alignment.center,
//               children: [
//                 NaverMap(
//                   options: const NaverMapViewOptions(
//                     locationButtonEnable: true,
//                     initialCameraPosition: NCameraPosition(
//                       target: NLatLng(33, 127.2164625),
//                       zoom: 10,
//                       bearing: 0,
//                       tilt: 0,
//                     ),
//
//                   ),
//                   onMapReady: (controller) {
//                     controller.addOverlay(marker);
//                     print("네이버 맵 로딩됨!");
//                   },
//                 ),
//                 // SafeArea(
//                 //   child: Align(
//                 //     alignment: Alignment.topLeft,
//                 //     child: Container(
//                 //       margin: const EdgeInsets.all(20),
//                 //       height: 50,
//                 //       width: 120,
//                 //       decoration: BoxDecoration(
//                 //         borderRadius: BorderRadius.circular(40),
//                 //         border: Border.all(
//                 //           color: Colors.black,
//                 //           width: 1,
//                 //         ),
//                 //         color: Colors.white,
//                 //       ),
//                 //       child: Row(
//                 //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //         children: [
//                 //           IconButton(
//                 //             onPressed: () {},
//                 //             icon: const Icon(Icons.add),
//                 //           ),
//                 //           IconButton(
//                 //             onPressed: () {},
//                 //             icon: const Icon(Icons.remove),
//                 //           ),
//                 //         ],
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//                 // Align(
//                 //   alignment: Alignment.bottomRight,
//                 //   child: Container(
//                 //     margin: const EdgeInsets.all(20),
//                 //     child: FloatingActionButton(
//                 //       elevation: 0,
//                 //       onPressed: () async {
//                 //         // await getClothesInfo(12, 21);
//                 //       },
//                 //       backgroundColor: Colors.white,
//                 //       shape: OutlineInputBorder(
//                 //         borderSide: const BorderSide(
//                 //           color: Colors.black,
//                 //           width: 1.0,
//                 //         ),
//                 //         borderRadius: BorderRadius.circular(50),
//                 //       ),
//                 //       child: const Icon(
//                 //         Icons.refresh,
//                 //         color: Colors.black,
//                 //       ),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//           );
//         }
//       },
//     );
//   }
// }