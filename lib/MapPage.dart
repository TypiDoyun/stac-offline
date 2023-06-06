import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline/main.dart';

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => MapPageState();
}

class MapPageState extends State<MapPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          color: Colors.blue,
          child: const Text("MapPage"),
        ),
        bottomNavigationBar: const BottomAppBar(),
      );
  }

  void changeScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

}