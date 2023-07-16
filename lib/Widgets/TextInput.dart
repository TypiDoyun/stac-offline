import 'package:flutter/material.dart';

class TextInput extends StatelessWidget {
  final controller;
  final String hintText;
  final bool obscureText;

  const TextInput({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.black,),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        fillColor: Colors.grey.shade100,
        filled: true,
      ),
      obscureText: obscureText,
    );
  }
}
