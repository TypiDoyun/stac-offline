import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatefulWidget {
  MainBottomNavigationBar({
    Key? key,
    required this.selectIndex,
    required this.iconItem1,
    required this.iconItem2,
    required this.iconItem3,
    required this.label1,
    required this.label2,
    required this.label3,
  }) : super(key: key);

  int selectIndex;
  final Icon iconItem1, iconItem2, iconItem3;
  final String label1, label2, label3;

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}
class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BottomNavigationBar(
      currentIndex: widget.selectIndex,
      onTap: (index) {
        setState(() {
          widget.selectIndex = index;
        });
      },
      items: [
        BottomNavigationBarItem(
          icon: widget.iconItem1,
          label: widget.label1,
        ),
        BottomNavigationBarItem(
            icon: widget.iconItem2,
            label: widget.label2,
        ),
        BottomNavigationBarItem(
          icon: widget.iconItem3,
          label: widget.label3,
        ),
      ],
      selectedItemColor: Theme.of(context).colorScheme.onTertiaryContainer,
      selectedFontSize: size.height * 0.013,
      selectedIconTheme: IconThemeData(size: size.height * 0.03),
      unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
      unselectedFontSize: size.height * 0.011,
      unselectedIconTheme: IconThemeData(size: size.height * 0.03),
      type: BottomNavigationBarType.fixed,
    );
  }
}
