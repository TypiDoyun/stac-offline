import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserHomeListItem extends StatelessWidget {
  UserHomeListItem({
    Key? key,
    required this.clothesName,
    required this.clothesPrice,
    required this.clothesImgPath,
    required this.discountRate,
    required this.onTap, required this.shopName,
  }) : super(key: key);

  final String clothesName, clothesImgPath, shopName;
  final int clothesPrice;
  final int? discountRate;
  final void Function() onTap;

  // final String shopName;

  final f = NumberFormat('###,###,###,###,###,###');


  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap;
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: Image.network(
                clothesImgPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  discountRate != 0 ? '$discountRate%' : '',
                  style: TextStyle(
                    color: discountRate != 0 ? Colors.red : Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.8,
                  ),
                ),
                SizedBox(
                  width: discountRate != 0 ? 5 : 0,
                ),
                Text(
                  discountRate != 0
                      ? '${f.format(clothesPrice - (clothesPrice * discountRate! / 100))}원'
                      : '${f.format(clothesPrice)}원',
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.6,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Text(
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
          const SizedBox(height: 5,),
          Text(
            shopName,
            style: const TextStyle(color: Colors.black54, fontSize: 11, letterSpacing: -0.6,),
          ),

        ],
      ),
    );
  }
}
