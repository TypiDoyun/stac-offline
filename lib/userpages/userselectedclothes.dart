import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:intl/intl.dart';

import '../classes/clothes.dart';

class UserSelectedClothesPage extends StatefulWidget {
  const UserSelectedClothesPage({Key? key, required this.clothesInfo})
      : super(key: key);
  final Clothes clothesInfo;

  @override
  State<UserSelectedClothesPage> createState() =>
      _UserSelectedClothesPageState(clothesInfo);
}

class _UserSelectedClothesPageState extends State<UserSelectedClothesPage> {
  final PageController _pageController = PageController();

  final image = [
    'assets/images/clothesImage1.jpeg',
    'assets/images/clothesImage2.jpeg',
    'assets/images/clothesImage3.jpeg'
  ];

  _UserSelectedClothesPageState(this.clothesInfo);

  final Clothes clothesInfo;

  var f = NumberFormat('###,###,###,###,###,###');

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  AspectRatio(
                    aspectRatio: 1,
                    child: ClipRRect(
                      child: PageView.builder(
                        itemCount: clothesInfo.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              // Make the height same as width for a square
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(clothesInfo.images[index]),
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: size.width * 0.03,
                        vertical: size.height * 0.01),
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 15,
                        ),
                      ],
                    ),
                    child: InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: size.width * 0.11,
                            width: size.width * 0.11,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              image: DecorationImage(
                                image:
                                    NetworkImage(clothesInfo.owner.shop.logo),
                                fit: BoxFit.cover, // 이미지가 잘리지 않도록 설정
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          SizedBox(
                            width: size.width * 0.52,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clothesInfo.owner.shop.name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
                                  "용인시 처인구 김량장동 어쩌구 301-112312",
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.grey),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.03,
                          ),
                          const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "현 위치로부터",
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
                              ),
                              Text(
                                "2.1km",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {},
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            clothesInfo.name,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  clothesInfo.discountRate == 0
                                      ? ''
                                      : '${clothesInfo.discountRate}%',
                                  style: TextStyle(
                                    color: clothesInfo.discountRate == 0
                                        ? Colors.black
                                        : Colors.red,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                                SizedBox(
                                  width: clothesInfo.discountRate == 0 ? 0 : 3,
                                ),
                                Text(
                                  clothesInfo.discountRate == 0
                                      ? '${f.format(clothesInfo.price)}원'
                                      : '${f.format((clothesInfo.price - (clothesInfo.price * clothesInfo.discountRate / 100)))}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.7,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              clothesInfo.discountRate == 0
                                  ? ""
                                  : "${f.format(clothesInfo.price)}원",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: const Divider(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Container(
                          margin: const EdgeInsets.all(13),
                          child: const Text(
                            "Size",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 13),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                clothesInfo.size.join(", "),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.07,
                        ),
                        Container(
                          margin: const EdgeInsets.all(15),
                          child: const Text(
                            "코멘트",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          height: size.height * 0.2,
                          width: size.width,
                          margin: EdgeInsets.only(bottom: size.height * 0.05),
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                spreadRadius: 1,
                                blurRadius: 15,
                              ),
                            ],
                          ),
                          child: Text(
                            "${clothesInfo.comment}",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: const Text(
                            "위치",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: size.height * 0.3,
                          child: const NaverMap(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              height: size.height * 0.1,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 8,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black38.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                ),
                              ]),
                          child: const Center(
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                ),
                              ]),
                          child: const Center(
                            child: Text(
                              "결제하기",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class Indicator extends StatelessWidget {
//   final bool isActive;
//
//   const Indicator({super.key, required this.isActive});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(4),
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(
//         box
//          BoxShadow(
//           color: Colors.grey.withOpacity(0.2),
//           spreadRadius: 1,
//           blurRadius: 15,
//         ),
//         color: isActive ? Colors.white.withOpacity(0.8) : Colors.grey,
//       ),
//     );
//   }
// }
