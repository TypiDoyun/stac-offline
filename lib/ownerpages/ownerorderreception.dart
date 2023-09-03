import 'package:flutter/material.dart';
import 'package:offline/Widgets/background.dart';

import '../Widgets/orderreceptionitem.dart';


class OrderReceptionPage extends StatefulWidget {
  const OrderReceptionPage({Key? key}) : super(key: key);

  @override
  State<OrderReceptionPage> createState() => _OrderReceptionPageState();
}

class _OrderReceptionPageState extends State<OrderReceptionPage> {
  final List<Map> clothesInfo = [
    {
      "clothesLocation": "G14_165",
      "username": "신승호",
      "address": "경기도 용인시 처인구 고림동",
      "price": 20000,
    },
    {
      "clothesLocation": "G14_165",
      "username": "신승호",
      "address": "경기도 용인시 처인구 고림동",
      "price": 20000,
    },
    {
      "clothesLocation": "G14_165",
      "username": "신승호",
      "address": "경기도 용인시 처인구 고림동",
      "price": 20000,
    },
    {
      "clothesLocation": "G14_165",
      "username": "신승호",
      "address": "경기도 용인시 처인구 고림동",
      "price": 20000,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("들어온 주문들", style: TextStyle(color: Colors.black)),
      ),
      body: Background(
        child: ListView.builder(
          itemCount: clothesInfo.length,
          itemBuilder: (context, index) {
            return OrderReceptionItem(
              clothesLocation: clothesInfo[index]["clothesLocation"],
              username: clothesInfo[index]["username"],
              address: clothesInfo[index]["address"],
              price: clothesInfo[index]["price"],
            );
          },
        ),
      ),
    );
  }
}
