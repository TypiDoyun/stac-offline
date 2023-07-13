import 'package:flutter/material.dart';
import 'package:offline/Widgets/SearchBar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
              SliverAppBar(
                toolbarHeight: 80,
                title: Search(),
                backgroundColor: Colors.white,
                pinned: false,
              ),
            const SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 그리드 열 개수
                  mainAxisSpacing: 20.0, // 그리드 행 간 간격
                  crossAxisSpacing: 30.0, // 그리드 열 간 간격
                  childAspectRatio: 0.8, // 아이템의 가로 세로 비율
                ),
                delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                    return OutlinedButton(
                      onPressed: () {},// 아이템 내용
                      style: OutlinedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20)
                              )
                          )
                      ),
                      child: const Text('Item'),
                    );
                  },
                  childCount: 20, // 전체 아이템 개수
                ),
              ),
            )],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 13),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)
                  )
                )
              ),
              onPressed: () {},
              child: const Text(
                "shop_name",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ]),
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
