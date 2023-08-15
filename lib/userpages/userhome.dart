import 'package:flutter/material.dart';
import 'package:offline/Widgets/mainlistitem.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {

  final List<Map<String, dynamic>> clothesInfo = [];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 60,
              title: Text(
                "Offline",
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
            if(clothesInfo.isEmpty)
              const SliverToBoxAdapter(child: Center(child: Text("암것도 없슈..."),) ,)
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
                sliver: SliverGrid(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 그리드 열 개수
                    mainAxisSpacing: 35.0, // 그리드 행 간 간격
                    crossAxisSpacing: 28.0, // 그리드 열 간 간격
                    childAspectRatio: 0.7, // 아이템의 가로 세로 비율
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return UserHomeListItem(
                        clothesName: clothesInfo[index]["name"],
                        clothesPrice: clothesInfo[index]["price"],
                        clothesImgPath: clothesInfo[index]["image"],
                        saleBoolen: clothesInfo[index]["sale_boolen"],
                        saleValue: clothesInfo[index]["sale_value"],
                        shopName: clothesInfo[index]["shop_name"],
                      );
                    },
                    childCount: clothesInfo.length, // 전체 아이템 개수
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  TabBarDelegate();

  var shop_nameList = ["MOVEMENT", "픽", "탑플레이스", "블루", "DATE", "DAISY"];

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: shop_nameList.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
              width: 80,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50)))),
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
