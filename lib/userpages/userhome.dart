import 'package:flutter/material.dart';
import 'package:offline/Widgets/mainlistitem.dart';
import 'package:offline/Widgets/user-main-shop-list-item.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  final List<Map<String, dynamic>> clothesInfo = [
    {
      "name": "BIG EVENT 남녀공용 블랙 레드 스트릿 후드티",
      "images": "assets/images/clothesImage4.jpeg",
      "price": 30000,
      "saleBool": true,
      "saleValue": 20,
    }

  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              toolbarHeight: size.height * 0.07,
              title: const Text(
                "Offline",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                ),
              ),
              pinned: false,
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(),
            ),
            if (clothesInfo.isEmpty)
              const SliverToBoxAdapter(
                child: Center(
                  child: Text(
                    "주변에 전시된 옷이 없어요...",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
                sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 그리드 열 개수
                    mainAxisSpacing: 35.0, // 그리드 행 간 간격
                    crossAxisSpacing: 28.0, // 그리드 열 간 간격
                    childAspectRatio: size.height * 0.00074, // 아이템의 가로 세로 비율
                  ),
                  delegate: SliverChildBuilderDelegate(
                    (BuildContext context, int index) {
                      return UserHomeListItem(
                        clothesName: clothesInfo[index]["name"],
                        clothesImgPath: clothesInfo[index]["images"],
                        clothesPrice: clothesInfo[index]["price"],
                        saleValue: clothesInfo[index]["saleValue"],
                        saleBoolen: clothesInfo[index]["saleBool"],
                      );
                    },
                    childCount: clothesInfo.length, // 전체 아이템 개수
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  var shopNameList = ["MOVEMENT", "픽", "탑플레이스", "블루", "DATE", "DAISY"];

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Center(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: shopNameList.length,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: shopListItem(
                  index: 0,
                  shopNameList: shopNameList,
                ),
              );
            }
            return shopListItem(
              index: index,
              shopNameList: shopNameList,
            );
          },
        ),
      ),
    );
  }

  @override
  double get maxExtent => 55;

  @override
  double get minExtent => 55;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
