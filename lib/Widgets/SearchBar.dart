import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final TextEditingController search = TextEditingController();

  Search({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        style: const TextStyle(fontSize: 16),
        textAlign: TextAlign.start,
        controller: search,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: "검색어 입력",
        ),
      ),
    );
  }

}