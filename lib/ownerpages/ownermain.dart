import 'package:flutter/material.dart';
import 'package:offline/ownerpages/clothesupload.dart';
import 'package:offline/ownerpages/ownerorderreception.dart';

import 'ownerhome.dart';


class OwnerMainPage extends StatefulWidget {
  const OwnerMainPage({Key? key}) : super(key: key);

  @override
  State<OwnerMainPage> createState() => _OwnerMainPageState();
}

class _OwnerMainPageState extends State<OwnerMainPage> {
  int selectIndex = 0;

  List bodyItem = [
    OwnerHomePage(),
    ClothesUploadPage(),
    OrderReceptionPage(),
  ];


  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: bodyItem.length,
      child: Scaffold(
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
              icon: Icon(Icons.home),
              label: "HOME",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "MAP",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.location_on),
              label: "MAP",
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}
