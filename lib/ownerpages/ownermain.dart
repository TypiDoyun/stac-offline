import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/clothesupload.dart';
import 'package:offline/ownerpages/ownerorderreception.dart';
import 'package:offline/userpages/usermain.dart';

import 'ownerhome.dart';


class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({super.key});


  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  int selectIndex = 0;

  List bodyItem = [
    const OwnerHomePage(),
    const ClothesUploadPage(),
    const OrderReceptionPage(),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: bodyItem.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          shadowColor: Colors.transparent,
          title: Text("Offline"),
          titleTextStyle: TextStyle(
            fontFamily: "GmarketSansKR",
            color: Theme.of(context).colorScheme.secondary,
            fontSize: size.height * 0.03,
            letterSpacing: size.width * -0.0033,
            fontWeight: FontWeight.w700,
          ),
          centerTitle: true,
          actions: [
            IconButton(onPressed: () {Get.offAll(UserMain());}, icon: Icon(Icons.logout),color: Colors.white,),
          ],
        ),
        body: bodyItem.elementAt(selectIndex),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectIndex,
          onTap: (index) {
            setState(() {
              selectIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.store),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_circle_outline_rounded),
              label: "DISPLAY",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: "SOLD",
            ),
          ],
          selectedItemColor: Theme.of(context).colorScheme.onTertiaryContainer,
          selectedFontSize: size.height * 0.013,
          selectedIconTheme: IconThemeData(size: size.height * 0.03),
          unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
          unselectedFontSize: size.height * 0.011,
          unselectedIconTheme: IconThemeData(size: size.height * 0.03),
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
