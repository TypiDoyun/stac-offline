import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/mainlistitem.dart';
import '../classes/clothes.dart';
import '../userpages/userhome.dart';
import '../userpages/userselectedclothes.dart';

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
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: CustomScrollView(
        // controller: controller,
        slivers: [
          SliverAppBar(
            backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
            foregroundColor: Theme.of(context).colorScheme.tertiary,
            centerTitle: true,
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
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  padding: EdgeInsets.symmetric(
                    horizontal: size.width * 0.03,
                    vertical: size.height * 0.03,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: size.width * 0.03),
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
                              style: TextStyle(
                                  fontSize: size.height * 0.024,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      Theme.of(context).colorScheme.tertiary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          const Text(
                            "경기도 용인시 처인구 고림동",
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
            padding: const EdgeInsets.fromLTRB(25, 20, 25, 30),
            sliver: shopInfos?.length == null
                ? const SliverToBoxAdapter(
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
    );
  }
}
