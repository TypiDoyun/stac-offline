import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/classes/shop.dart';
import 'package:offline/ownerpages/modifyclothesinfo.dart';
import 'package:offline/utils/shop/remove-clothes-info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/ownerclotheslistitem.dart';
import '../classes/clothes.dart';
import '../userpages/userhome.dart';
import '../utils/common/get-owner-clothes-info.dart';

//점주 화면
class OwnerHomePage extends StatefulWidget {
  const OwnerHomePage({Key? key}) : super(key: key);

  @override
  State<OwnerHomePage> createState() => _OwnerPageState();
}

class _OwnerPageState extends State<OwnerHomePage> {

  Shop? shopInfo;
  bool loadingData = true;
  List<Clothes>? clothes;
  String accessToken = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getClothesInfo();
  }

  Future<void> getClothesInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    accessToken = prefs.getString("accessToken")!;

    try {
      List<Clothes> clothesList = await getOwnerClothesInfo(accessToken);
      setState(() {
        clothes = clothesList;
        shopInfo = Shop(
          name: prefs.getString("shopname")!,
          shopNumber: prefs.getString("shopNumber")!,
          logo: prefs.getString("logo")!,
          registrationNumber: prefs.getString("registrationNumber")!,
          address: prefs.getString("address")!,
          location: [prefs.getDouble("location_la")!, prefs.getDouble("location_lo")!],
        );
        loadingData = false; // 데이터 로딩이 끝났음을 표시
      });
    } catch (e) {
      print("Error: $e");
      loadingData = false; // 데이터 로딩이 실패했음을 표시
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loadingData
        ? Center(
      child: CircularProgressIndicator(
        strokeAlign: BorderSide.strokeAlignCenter,
      ),
    )
        : Scaffold(
      // 로딩이 끝나면 실제 화면을 구성합니다.
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(
                  maxHeight: size.width * 0.3,
                  minHeight: size.width * 0.3,
                  child: Container(
                    height: size.height * 0.2,
                    color:
                    Theme.of(context).colorScheme.tertiaryContainer,
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.03,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: size.width * 0.03),
                          height: size.width * 0.25,
                          width: size.width * 0.25,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(
                                  "https://dy-03-bucket.s3.ap-northeast-2.amazonaws.com/bomb.png"),
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 10),
                              width: size.width * 0.6,
                              child: Text(
                                shopInfo == null
                                    ? "로딩중"
                                    : shopInfo!.name,
                                style: TextStyle(
                                    fontSize: size.height * 0.024,
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .tertiary),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              shopInfo == null
                                  ? "로딩중"
                                  : shopInfo!.address,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              sliver: clothes?.length == 0
                  ? const SliverToBoxAdapter(
                child: Center(
                  child: Text("본 매장에서 전시한 옷이 없어요..."),
                ),
              )
                  : SliverList(
                delegate: SliverChildBuilderDelegate(
                  childCount: clothes!.length,
                      (context, index) => OwnerClothesListItem(
                    clothesName: clothes![index].name,
                    clothesPrice: clothes![index].price,
                    clothesSize: clothes![index].size[0],
                    clothesComment: clothes![index].comment,
                    clothesImage: clothes![index].images[0],
                    onTap: () {
                      Get.to(const ModityClothesInfo());
                    },
                    onPressedDelete: () async {
                      await removeClothesInfo(
                          clothes![index].name, accessToken);
                      clothes = await getOwnerClothesInfo(
                          accessToken);
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
