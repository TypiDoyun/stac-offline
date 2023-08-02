import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:offline/userpages/User_SelectedclothesPage.dart';

class UserHomeListItem extends StatelessWidget {
  UserHomeListItem({
    Key? key,
    required this.clothes_name,
    required this.clothes_price,
    required this.clothes_imgPath,
    required this.sale_boolen,
    required this.sale_value,
    required this.shop_name,
  }) : super(key: key);

  final String clothes_name;
  final num clothes_price;
  final String clothes_imgPath;
  final bool sale_boolen;
  final int? sale_value;
  final String shop_name;

  var f = NumberFormat('###,###,###,###,###,###');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => UserSelectedClothesPage());
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.asset(
                clothes_imgPath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            clothes_name,
            style: const TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w600),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            shop_name,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
          Row(
            children: [
              Text(
                sale_boolen  ? '$sale_value%' : '',
                style: TextStyle(
                  color: sale_boolen ? Colors.red : Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                width: sale_boolen ? 3 : 0,
              ),
              Text(
                sale_boolen
                    ? f.format((clothes_price - (clothes_price * sale_value! / 100)))
                    : f.format(clothes_price),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

