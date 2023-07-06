import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: Color(0xffeeeeee),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
          IconButton(
            icon: Icon(Icons.coffee, color: Colors.black),
            onPressed: null,
          ),
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
        ],
      ),
    );
  }
}