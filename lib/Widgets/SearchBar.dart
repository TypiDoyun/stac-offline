import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  final TextEditingController search = TextEditingController();

  Search({super.key});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: TextField(
        style: const TextStyle(fontSize: 13),
        textAlign: TextAlign.start,
        controller: search,
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50)
          ),
          hintText: "검색어 입력",
        ),
      ),
    );
  }

}