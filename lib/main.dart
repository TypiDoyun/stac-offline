import 'package:flutter/material.dart';
import 'package:offline/ClothesUpload.dart';
import 'package:offline/MainPage.dart';
import 'package:offline/MapPage.dart';
import 'package:offline/UserPage.dart';



void main() {
  return runApp(const MaterialApp(home: UserMian()));
}
//점주 화면
class OwnerMain extends StatefulWidget {
  const OwnerMain({super.key});

  List<Widget> getWidgets() {
    List<Widget> widgets = [];
    for (var i = 0; i < 20; i++){
      widgets.add(ListTile(title: Text("test $i"),));
    }
    return widgets;
  }

  @override
  State<OwnerMain> createState() => OwnerMainState();
}
class OwnerMainState extends State<OwnerMain> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: CustomScrollView(
            slivers: [
              const SliverAppBar(
                title: Text("어서오세요 {가게이름} 사장님!",style: TextStyle(color: Colors.black,fontSize: 23,fontWeight: FontWeight.w700),),
                backgroundColor: Colors.white,
                pinned: false,
              ),
              SliverPersistentHeader(
                  delegate: SampleHeaderDelegate(
                    widget: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ClothesUpload()),
                        );
                      },
                      child: Container(
                        color: Colors.white,
                        height: 100,
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("옷 전시하기",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 23,
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                pinned: true,
              ),
              SliverFixedExtentList(
                itemExtent: 50.0,
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ListTile(
                      title: Text('test $index'),
                    );
                  })
              )],
          ),
      )
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

//소비자 화면
class UserMian extends StatefulWidget {
  const UserMian({super.key});

  @override
  State<UserMian> createState() => MyTest();
}
class MyTest extends State<UserMian> {
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