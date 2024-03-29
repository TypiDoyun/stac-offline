import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerClothesListItem extends StatelessWidget {
  const OwnerClothesListItem({
    Key? key,
    required this.clothesName,
    required this.clothesPrice,
    required this.clothesSize,
    required this.clothesComment,
    required this.onPressedDelete,
    this.clothesImage,
    required this.onTap,
  }) : super(key: key);

  final String? clothesName, clothesSize, clothesComment;
  final int clothesPrice;
  final dynamic clothesImage, onPressedDelete, onTap;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return clothesName == null ? CircularProgressIndicator() :
      InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.width * 0.01),
        height: size.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: size.width * 0.3,
              width: size.width * 0.3,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                      clothesImage),
                  fit: BoxFit.contain, // 이미지가 잘리지 않도록 설정
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  clothesName!,
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clothesPrice.toString(),
                        style: TextStyle(
                          fontSize: size.height * 0.015,
                        ),
                      ),
                      Text(
                        clothesSize == "Free" ? "Free" : "85(XS) ~ 110(2XL)",
                        style: TextStyle(
                          fontSize: size.height * 0.015,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          clothesComment!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size.height * 0.013,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            IconButton(
              onPressed: () {Get.dialog(
                (AlertDialog(
                  title: const Text("정말로 전시를 중지하실껀가요?"),
                  actions: [
                    TextButton(
                        child: const Text("아니요"), onPressed: () async {}),
                    TextButton(
                      child: const Text("네"),
                      onPressed: () {
                        Get.back();
                        onPressedDelete;
                      },
                    ),
                  ],
                )),
              );}, icon: const Icon(Icons.delete),
            ),
          ],
        ), //dense: true,
      ),
    );
    // InkWell(
    //   onTap: () {
    //     onTap();
    //   },
    //   child: Container(
    //     alignment: Alignment.center,
    //     child: Row(
    //       children: [
    //         Container(
    //           color: Colors.black,
    //           height: 120,
    //           width: 120,
    //         ),
    //         Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 10),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 clothesName,
    //                 style: TextStyle(fontSize: 13),
    //               ),
    //               const SizedBox(
    //                 height: 13,
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     clothesSize,
    //                     style: TextStyle(fontSize: 10),
    //                   ),
    //                   Text(
    //                     clothesComment,
    //                     style: TextStyle(fontSize: 10),
    //                   ),
    //                   Text(
    //                     clothesPrice.toString(),
    //                     style: TextStyle(fontSize: 10),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               IconButton(
    //                 icon: Icon(Icons.delete),
    //                 onPressed: () {
    //                   onPressedDelete;
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
