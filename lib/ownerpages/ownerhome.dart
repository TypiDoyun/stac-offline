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
                  const SliverAppBar(
                    backgroundColor: Colors.black,
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
                              await Get.to(() => const ClothesUploadPage());
                            },
                            child: const Text(
                              "옷 전시하기",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 24),
                            )),
                      ),
                    ),
                    pinned: true,
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: clothesList.length,
                      (context, index) => OwnerClothesListItem(
                        clothesName: clothesList[index]['name'],
                        clothesPrice: clothesList[index]['price'],
                        clothesSize: clothesList[index]['size'],
                        clothesComment: clothesList[index]['comment'],
                        onTap: () {
                          Get.to(() => const ModityClothesInfo());
                        },
                        onPressedDelete: () async {
                          await removeClothesInfo();
                          // setState(() {});
                        },
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
