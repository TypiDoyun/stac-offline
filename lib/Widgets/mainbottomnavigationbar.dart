import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatefulWidget {
  MainBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.iconItem1,
    required this.iconItem2,
    required this.iconItem3,
    required this.label1,
    required this.label2,
    required this.label3,
  }) : super(key: key);

  int selectedIndex; // 이름을 selectIndex에서 selectedIndex로 변경
  final Icon iconItem1, iconItem2, iconItem3;
  final String label1, label2, label3;

  @override
  State<MainBottomNavigationBar> createState() => _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {

  @override
  Widget build(BuildContext context) {
    // selectedIndex를 widget.selectedIndex로 변경
    return BottomNavigationBar(
      currentIndex: widget.selectedIndex,
      onTap: (index) {
        // widget.selectedIndex를 업데이트하도록 변경
        setState(() {
          widget.selectedIndex = index;
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
      selectedFontSize: MediaQuery.of(context).size.height * 0.013,
      selectedIconTheme: IconThemeData(size: MediaQuery.of(context).size.height * 0.03),
      unselectedItemColor: Theme.of(context).colorScheme.onSecondary,
      unselectedFontSize: MediaQuery.of(context).size.height * 0.011,
      unselectedIconTheme: IconThemeData(size: MediaQuery.of(context).size.height * 0.03),
      type: BottomNavigationBarType.fixed,
    );
  }
}
