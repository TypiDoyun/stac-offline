import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/modifyclothesinfo.dart';
import 'package:offline/utils/common/remove-clothes-info.dart';
import 'package:offline/utils/common/try-get-clothes-info.dart';

import 'clothesupload.dart';
import '../Widgets/ownerclotheslistitem.dart';

//점주 화면
class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({Key? key}) : super(key: key);

  @override
  State<OwnerHomePage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerHomePage> {
  List<Map> clothesList = [
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
    {"name": "dkdkd", "price": 20000, "comment": "dg", "size": "free"},
  ];

  Future<void>? dataLoading;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      //옷 정보 가져오는 API
    }());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
            body: SafeArea(
              child: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    backgroundColor: Colors.black,
                    title: Text(
                      "Offline",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: size.height * 0.03),
                    ),
                    centerTitle: true,
                    pinned: false,
                  ),
                  SliverPersistentHeader(
                    delegate: SampleHeaderDelegate(
                        widget: Container(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            color: Theme.of(context).colorScheme.background,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "가게이름",
                                  style:
                                      TextStyle(fontSize: size.height * 0.03),
                                ),
                                Text("경기도 용인시 처인구 고림동"),
                              ],
                            ))),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount: clothesList.length,
                        (context, index) => OwnerClothesListItem(
                          clothesName: clothesList[index]['name'],
                          clothesPrice: clothesList[index]['price'],
                          clothesSize: clothesList[index]['size'],
                          clothesComment: clothesList[index]['comment'],
                          onTap: () {
                            Get.to(const ModityClothesInfo());
                          },
                          onPressedDelete: () async {
                            await removeClothesInfo();
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class SampleHeaderDelegate extends SliverPersistentHeaderDelegate {
  SampleHeaderDelegate({required this.widget}) {}

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
