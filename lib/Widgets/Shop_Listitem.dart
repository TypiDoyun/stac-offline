import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShopListItem extends StatelessWidget{
  final String shopName = 'test';
  // final FileImage? shopImage;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
            child: Text(
              shopName,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            color: Color(0xffeeeeee),
          ),
          Container(
            width: 5,
          )
        ]
    );
  }

}