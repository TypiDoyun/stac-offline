

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const BottomAppBar(
      color: const Color(0xffeeeeee),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
          IconButton(
            icon: const Icon(Icons.coffee, color: Colors.black),
            onPressed: null,
          ),
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
          IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
        ],
      ),
    );
  }
}