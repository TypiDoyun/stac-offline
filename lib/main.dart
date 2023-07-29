import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:get/get.dart';
import 'package:offline/ClothesUpload.dart';
import 'package:offline/MainPage.dart';
import 'package:offline/UserPage.dart';
import 'package:offline/Widgets/Owner_ClothesListItem.dart';

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

  return runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: const UserMain(),
    theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: primaryBlack,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        )),
  ));
}

//소비자 화면
class UserMain extends StatefulWidget {
  const UserMain({super.key});

  @override
  State<UserMain> createState() => UserMainState();
}

class UserMainState extends State<UserMain> {
  int current_index = 0;

  //네이게이션바 화면 순서
  List<dynamic> body_item = [
    const MainPage(),
    const MapPage(),
    const UserPage(),
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

//점주 화면
class OwnerMain extends StatefulWidget {
  const OwnerMain({super.key});

  @override
  State<OwnerMain> createState() => OwnerMainState();
}

class OwnerMainState extends State<OwnerMain> {
  List<Map<String, dynamic>> clothesList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 80,
              title: Text(
                "어서오세요 '가게이름' 사장님!",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 23,
                    fontWeight: FontWeight.w700),
              ),
              backgroundColor: Colors.white,
              pinned: false,
            ),
            SliverPersistentHeader(
              delegate: SampleHeaderDelegate(
                widget: SizedBox(
                  height: 100,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero,
                        ),
                      ),
                      onPressed: () async {
                        final val = await Get.to(() => const ClothesUpload());
                        if (val != null) {
                          setState(() {
                            clothesList.add(val);
                          });
                        };
                      },
                      child: const Text(
                        "옷 전시하기",
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      )),
                ),
              ),
              pinned: true,
            ),
            SliverList(
                delegate: SliverChildBuilderDelegate(
                    childCount: clothesList.length,
                    (context, index) => OwnerClothesListItem(
                        clothes_name: clothesList[index]['name'],
                        clothes_price: clothesList[index]['price'],
                        clothes_size: clothesList[index]['size'],
                        clothes_tag: clothesList[index]['tag'],
                        clothes_comment: clothesList[index]['comment'])))
          ],
        ),
      ),
    );
  }
}

class SampleHeaderDelegate extends SliverPersistentHeaderDelegate {
  SampleHeaderDelegate({required this.widget});

  Widget widget;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return widget;
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
