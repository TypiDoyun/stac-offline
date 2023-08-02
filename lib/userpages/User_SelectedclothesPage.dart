import 'package:flutter/material.dart';

class UserSelectedClothesPage extends StatefulWidget {
  const UserSelectedClothesPage({Key? key}) : super(key: key);

  @override
  State<UserSelectedClothesPage> createState() => _UserSelectedClothesPageState();
}

class _UserSelectedClothesPageState extends State<UserSelectedClothesPage> {
  final PageController _pageController = PageController();

  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("옷 페이지"),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: MediaQuery.of(context).size.width,
              color: Colors.grey[300],
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  Image.network('https://via.placeholder.com/300'),
                  Image.network('https://via.placeholder.com/400'),
                  Image.network('https://via.placeholder.com/500'),
                ],
              ),
            ),
            // Bottom Section: Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Total number of pages (change this according to your images)
                    (index) => Indicator(isActive: index == _currentPage),
              ),
            ),
          ],
        ),
      )
    );
  }
}

class Indicator extends StatelessWidget {
  final bool isActive;
  const Indicator({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? Colors.white.withOpacity(0.8) : Colors.grey,
      ),
    );
  }
}