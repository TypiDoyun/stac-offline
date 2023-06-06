import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopListItem extends StatelessWidget {
  final String? shopName = null;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration( //컨테이너 데코레이션
        borderRadius: BorderRadius.circular(50),
        color: const Color(0xffeeeeee),

    ),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 40,width: 80,
      child: const Row(mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
  }
}
