import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline/Widgets/LikeItem.dart';

class LikePage extends StatefulWidget{
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
            LikeItem(),
            LikeItem(),
            LikeItem(),
          ],
        ).toList(),
      ),
    );
  }

}