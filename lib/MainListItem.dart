

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainItemList extends StatelessWidget {
  final String clothes_name;
  final int clothes_price;
  final Image clothes_images;

  const MainItemList(
      {Key? key, required this.clothes_name, required this.clothes_price, required this.clothes_images, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,
        backgroundColor: Colors.black.withOpacity(0),
        shadowColor: Colors.white.withOpacity(0),
      ),
      child: Column(
        children: [
          Container(height: 150, width: 300,
            child: clothes_images,
            ),
          const SizedBox(height: 5,),
          Align(
            alignment: const FractionalOffset(0,0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(clothes_name,
                  style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.w700
                  ),
                ),
                const SizedBox(height: 4,),
                Text("$clothes_price₩",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
  }
}
