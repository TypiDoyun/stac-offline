import 'package:flutter/material.dart';

class MainBottomNavigationBar extends StatelessWidget {
  const MainBottomNavigationBar({
    Key? key,
    required this.selectedIndex,
    required this.iconItem1,
    required this.iconItem2,
    required this.iconItem3,
    required this.label1,
    required this.label2,
    required this.label3,
    required this.onIndexChanged, // 추가: 인덱스 변경 콜백
  }) : super(key: key);

  final int selectedIndex;
  final Icon iconItem1, iconItem2, iconItem3;
  final String label1, label2, label3;
  final void Function(int) onIndexChanged; // 추가: 인덱스 변경 콜백

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: onIndexChanged, // 변경: 콜백 호출
      items: [
        BottomNavigationBarItem(
          icon: iconItem1,
          label: label1,
        ),
        BottomNavigationBarItem(
          icon: iconItem2,
          label: label2,
        ),
        BottomNavigationBarItem(
          icon: iconItem3,
          label: label3,
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
