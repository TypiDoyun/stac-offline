import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/clothesupload.dart';
import 'package:offline/ownerpages/ownerorderreception.dart';
import 'package:offline/userpages/usermain.dart';
import 'package:offline/utils/common/get-owner-clothes-info.dart';
import 'package:offline/utils/shop/get-shop-info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../classes/shop.dart';
import '../utils/common/fetch-user-data.dart';
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
  String? accessToken, shopName, address, logo;
  Shop? shopInfo;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    (() async {
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      await fetchShopData(prefrs.getString("accessToken"));

    })();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return DefaultTabController(
      length: bodyItem.length,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          shadowColor: Colors.transparent,
          title: const Text("Offline"),
          titleTextStyle: TextStyle(
            fontFamily: "GmarketSansKR",
            color: Theme.of(context).colorScheme.secondary,
            fontSize: size.height * 0.03,
            letterSpacing: size.width * -0.004,
            fontWeight: FontWeight.normal,
          ),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
                SharedPreferences prefrs =
                    await SharedPreferences.getInstance();
                prefrs.remove("accessToken");
                Get.offAll(const UserMain());
              },
              icon: const Icon(Icons.logout),
              color: Colors.white,
            ),
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
              icon: Icon(
                Icons.store,
              ),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline_rounded,
              ),
              label: "DISPLAY",
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.check,
              ),
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
