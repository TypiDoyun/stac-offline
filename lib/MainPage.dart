import 'package:flutter/material.dart';
import 'package:offline/Widgets/SearchBar.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Search(),
              backgroundColor: Colors.white,
              pinned: false,
            ),
            const SliverPersistentHeader(
              pinned: true,
              delegate: TabBarDelegate(),
            ),
            SliverFixedExtentList(
              itemExtent: 100.0,
              delegate: SliverChildBuilderDelegate((context, index) {
                return const ListTile(
                  title: Text('test'),
                );
              })),
          ],
        ),
      ),
    );
  }
}

class TabBarDelegate extends SliverPersistentHeaderDelegate {
  const TabBarDelegate();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(children: [
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            Container(
              height: 40,
              width: 80,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                "안녕",
                style: TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
