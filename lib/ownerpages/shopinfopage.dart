import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

import '../Widgets/mainlistitem.dart';
import '../classes/clothes.dart';
import '../userpages/userhome.dart';
import '../userpages/userselectedclothes.dart';
import '../utils/common/try-get-clothes-info.dart';

class ShopInfoPage extends StatefulWidget {
  const ShopInfoPage({
    Key? key,
    this.shopInfo,
    this.shopInfos,
  }) : super(key: key);
  final Clothes? shopInfo;
  final List<Clothes>? shopInfos;

  @override
  State<ShopInfoPage> createState() => _ShopInfoPageState(shopInfo, shopInfos);
}

class _ShopInfoPageState extends State<ShopInfoPage> {
  _ShopInfoPageState(this.shopInfo, this.shopInfos);

  final Clothes? shopInfo;
  final List<Clothes>? shopInfos;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          // controller: controller,
          slivers: [
            SliverAppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              centerTitle: true,
              pinned: true,
            ),
            // SliverPersistentHeader(
            //   delegate: TabBarDelegate(
            //     maxHeight: 70,
            //     minHeight: 70,
            //     child: Container(
            //       padding: const EdgeInsets.only(left: 20),
            //       height: 70,
            //       alignment: Alignment.bottomLeft,
            //       child: const Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: [
            //           Text(
            //             "경기도 용인시 처인구 고림동",
            //             style: TextStyle(
            //               fontSize: 13,
            //               fontWeight: FontWeight.bold,
            //               color: Colors.black38,
            //             ),
            //           ),
            //           Text(
            //             "주변에 있는 옷가게들이에요.",
            //             style: TextStyle(
            //                 fontSize: 17, fontWeight: FontWeight.bold),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // ),
            SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(
                  maxHeight: size.width * 0.35,
                  minHeight: size.width * 0.35,
                  child: Container(
                    height: size.height * 0.2,
                    margin: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                      vertical: size.height * 0.01,
                    ),
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.background,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                      ],
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
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: AssetImage('assets/images/test.png'),
                              fit: BoxFit.cover, // 이미지가 잘리지 않도록 설정
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              width: size.width * 0.6,
                              child: Text(
                                "가게이름",
                                style: const TextStyle(
                                    fontSize: 23, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              "경기도 용인시 처인구 고림동",
                              style: const TextStyle(
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
            // if (shopInfo.name.isEmpty)
            //   SliverToBoxAdapter(
            //     child: SizedBox(
            //       height: size.height * 0.6,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const Text(
            //             "주변에 전시된 옷이 없어요...",
            //             style: TextStyle(
            //               color: Colors.black,
            //               fontSize: 16,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           IconButton(
            //               onPressed: () async {
            //               },
            //               icon: const Icon(Icons.refresh)),
            //         ],
            //       ),
            //     ),
            //   )
            // else
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
              sliver: shopInfos?.length == null
                  ? SliverToBoxAdapter(
                      child: Center(
                        child: Text("본 매장에서 전시한 옷이 없어요..."),
                      ),
                    )
                  : SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // 그리드 열 개수
                        mainAxisSpacing: 35.0, // 그리드 행 간 간격
                        crossAxisSpacing: 28.0, // 그리드 열 간 간격
                        childAspectRatio: size.height * 0.0007, // 아이템의 가로 세로 비율
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          // if (index < clothesInfo.length) {

                          return UserHomeListItem(
                            clothesName: shopInfos![index].name,
                            clothesImgPath: shopInfos![index].images[0],
                            clothesPrice: shopInfos![index].price,
                            discountRate: shopInfos![index].discountRate,
                            shopName: shopInfo!.owner.shop.name,
                            onTap: () {
                              Get.to(() => UserSelectedClothesPage(
                                  clothesInfo: shopInfos![index]));
                            },
                          );
                        },
                        childCount: 5, // 전체 아이템 개수
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
