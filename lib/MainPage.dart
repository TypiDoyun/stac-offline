import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Widgets/Shop_Listitem.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        body: TabBarView(children: [
          Column(children: [
            const SizedBox(
              height: 25,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  const SizedBox(width: 20),
                  ShopListItem(),
                  ShopListItem(),
                  ShopListItem(),
                  ShopListItem(),
                  ShopListItem(),
                  ShopListItem(),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
            )
          ])
        ]));
  }
}
