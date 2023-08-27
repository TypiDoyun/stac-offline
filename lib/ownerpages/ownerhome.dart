import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/modifyclothesinfo.dart';
import 'package:offline/utils/common/try-get-clothes-info.dart';

import 'clothesupload.dart';
import '../Widgets/ownerclotheslistitem.dart';

//점주 화면
class OwnerPage extends StatefulWidget {
  const OwnerPage({Key? key}) : super(key: key);

  @override
  State<OwnerPage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerPage> {
  List<Map> clothesList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      // await getClothesInfo(a, b)
    }());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              toolbarHeight: 80,
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
                        final val =
                            await Get.to(() => const ClothesUploadPage());
                        if (val != null) {
                          setState(() {
                            clothesList.add(val);
                          });
                        }
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
                  clothesName: clothesList[index]['name'],
                  clothesPrice: clothesList[index]['price'],
                  clothesSize: clothesList[index]['size'],
                  clothesTag: clothesList[index]['tag'],
                  clothesComment: clothesList[index]['comment'],
                  onTapPage: const ModityClothesInfo(),
                ),
              ),
            ),
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
