import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:offline/userpages/userselectedclothes.dart';

class UserHomeListItem extends StatelessWidget {
  UserHomeListItem({
    Key? key,
    required this.clothesName,
    required this.clothesPrice,
    required this.clothesImgPath,
    this.saleValue,
    required this.saleBoolen,
    // required this.shopName,
  }) : super(key: key);

  final String clothesName, clothesImgPath;
  final int clothesPrice;
  final int? saleValue;
  final bool saleBoolen;

  // final String shopName;

  var f = NumberFormat('###,###,###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => const UserSelectedClothesPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.asset(
                clothesImgPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Text(
              clothesName,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 13,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.6,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 3),
            child: const Text(
              "MOVEMENT",
              style: TextStyle(color: Colors.black54, fontSize: 12),
            ),
          ),
          Row(
            children: [
              Text(
                saleBoolen ? '$saleValue%' : '',
                style: TextStyle(
                  color: saleBoolen ? Colors.red : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.8,
                ),
              ),
              SizedBox(
                width: saleBoolen ? 3 : 0,
              ),
              Text(
                saleBoolen
                    ? f.format(
                        (clothesPrice - (clothesPrice * saleValue! / 100)))
                    : f.format(clothesPrice),
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.7,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
