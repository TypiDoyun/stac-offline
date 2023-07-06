import 'package:flutter/material.dart';

class LikePage extends StatefulWidget{
  const LikePage({super.key});

  @override
  State<LikePage> createState() => LikePageState();
}
class LikePageState extends State<LikePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: ListTile.divideTiles(
          context: context,
          tiles: [
          ],
        ).toList(),
      ),
    );
  }

}