import 'package:flutter/material.dart';
import 'package:offline/Widgets/MainListItem.dart';


class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {

  var item_titleList = [
    "블랙 자켓",
    "화이트 셔츠",
    "남성 블랙 진",
    "블랙 미니 스커트",
    "아이보리 남성 니트",
    "TOMATH 화이트 반팔티",
    "카키 조거팬츠",
    "TOMATH 블랙 반팔티",
];
  var item_priceList = [
    10000,
    13000,
    20000,
    15000,
    30000,
    20000,
    30000,
    20000,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
              const SliverAppBar(
                toolbarHeight: 60,
                title: Text("Offline",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 28,
                  ),
                ),
                backgroundColor: Colors.white,
                pinned: false,
              ),
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(),
            ),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(30,20,30,30),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 그리드 열 개수
                  mainAxisSpacing: 30.0, // 그리드 행 간 간격
                  crossAxisSpacing: 30.0, // 그리드 열 간 간격
                  childAspectRatio: 0.68, // 아이템의 가로 세로 비율
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return MainItemList(clothes_name: item_titleList[index], clothes_price: item_priceList[index], clothes_images: Image.asset('assets/images/test.png'));
                  },
                  childCount: item_titleList.length, // 전체 아이템 개수
                ),
              ),
            )],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  TabBarDelegate();
  var shop_nameList = [
    "MOVEMENT",
    "픽",
    "탑플레이스",
    "블루",
    "DATE",
    "DAISY"
  ];

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Center(
        child:
        ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: shop_nameList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16,horizontal: 8),
              width: 80,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)
                    )
                  )
                ),
                onPressed: () {},
                child: Text(
                  shop_nameList[index],
                  style: const TextStyle(color: Colors.black, fontSize: 12),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
