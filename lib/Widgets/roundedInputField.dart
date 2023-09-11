import 'package:flutter/material.dart';

class TextFieldContainer extends StatelessWidget {
  final Color? color;
  final bool obscureText;
  final String hintText;
  final FormFieldValidator validator;
  final IconData icon;
  final bool? enabled;
  final FormFieldSetter? onSaved;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? initialValue;

  const TextFieldContainer({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.icon,
    this.color,
    this.enabled,
    this.onSaved,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.obscureText = false, this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.003),
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        autovalidateMode: AutovalidateMode.always,
        keyboardType: keyboardType,
        enabled: enabled,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: size.height * 0.015,
          ),
        ),
      ),
    );
  }
}
