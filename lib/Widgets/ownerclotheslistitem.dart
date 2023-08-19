import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerClothesListItem extends StatelessWidget {
  final String clothesName, clothesTag, clothesSize, clothesComment;
  final int clothesPrice;
  final dynamic onTapPage;
  final dynamic clothesImage;

  const OwnerClothesListItem({
    Key? key,
    required this.clothesName,
    required this.clothesPrice,
    required this.clothesSize,
    required this.clothesTag,
    required this.clothesComment,
    required this.onTapPage, this.clothesImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Get.to(onTapPage);
        },
        child: Card(
          elevation: 6,
          margin: const EdgeInsets.all(10),
          shadowColor: Colors.black26,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  color: Colors.black,
                  height: 100,
                  width: 100,
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clothesName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        clothesComment,
                        maxLines: 3,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        clothesPrice as String,
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.red),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
