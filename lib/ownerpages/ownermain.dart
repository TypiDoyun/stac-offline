import 'package:flutter/material.dart';
import 'package:offline/ownerpages/clothesupload.dart';
import 'package:offline/ownerpages/ownerorderreception.dart';

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
            color: Theme.of(context).colorScheme.secondary,
            fontSize: size.height * 0.03,
          ),
          centerTitle: true,
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
