import 'package:flutter/material.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool obscureText = false;
  final String hintText;
  final FormFieldValidator validator;
  final IconData icon;
  final bool? enabled;
  final FormFieldSetter? onSave;
  final TextInputType? keyboardType;
  final Function(String) onChanged;
  final TextEditingController? controller;

  const TextFieldContainer({Key? key,
    required this.child,
    required this.color, required this.hintText, required this.validator, required this.icon, this.enabled, this.onSave, this.keyboardType, this.controller, required this.onChanged,
  })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.003),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator,
        autovalidateMode: AutovalidateMode.always,
        keyboardType: keyboardType,
        enabled: enabled,
        obscureText: obscureText,
        decoration: InputDecoration(
            icon: Icon(icon),
            hintText: hintText,
            border: InputBorder.none,
            hintStyle: TextStyle(fontSize: size.height * 0.015)
        ),
      ),
    );
  }
}
