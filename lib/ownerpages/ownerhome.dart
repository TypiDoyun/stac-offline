import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/modifyclothesinfo.dart';

import 'clothesupload.dart';
import '../Widgets/ownerclotheslistitem.dart';

//점주 화면
class OwnerPage extends StatefulWidget {
  const OwnerPage({Key? key}) : super(key: key);

  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  List<Map> clothesList = [
  ];


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
                        final val = await Get.to(() => const ClothesUploadPage());
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
                        clothes_comment: clothesList[index]['comment'], onTapPage: ModityClothesInfo(),)))
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