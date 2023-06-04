import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:offline/main.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => MapScreenState();
}

class MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("둘러보기"),
          titleTextStyle: const TextStyle(color: Colors.black),
          backgroundColor: const Color(0xffeeeeee),
        ),
        bottomNavigationBar: BottomAppBar(
          color: const Color(0xffeeeeee),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
              const IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
              IconButton(
                icon: const Icon(Icons.coffee, color: Colors.black),
                onPressed: () {
                  changeScreen(context);
                },
              ),
              const IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
              const IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
            ],
          ),
        ),
      ),
    );
  }

  void changeScreen(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

}