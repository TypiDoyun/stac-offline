import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerClothesListItem extends StatelessWidget {
  final String clothes_name, clothes_tag, clothes_size, clothes_comment;
  final int clothes_price;
  final onTapPage;
  final clothesImage;

  const OwnerClothesListItem({
    Key? key,
    required this.clothes_name,
    required this.clothes_price,
    required this.clothes_size,
    required this.clothes_tag,
    required this.clothes_comment,
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
          margin: EdgeInsets.all(10),
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
                        clothes_name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        clothes_comment,
                        maxLines: 3,
                        style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                        ),
                      ),
                      Text(
                        clothes_price as String,
                        style: TextStyle(
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
