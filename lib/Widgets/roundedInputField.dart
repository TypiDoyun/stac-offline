import 'package:flutter/material.dart';

roundedInputField({
  required String hintText,
  required TextInputType keyboardType,
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
  required IconData icon,
  required bool enabled,
  required Color color,
  TextEditingController? controller,
  bool obscureText = false,
  Function(String)? onChanged,
}) {
  return TextFieldContainer(
    color: color,
    child: TextFormField(
      controller: controller,
      onSaved: onSaved,
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
      ),
    ),
  );
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;

  const TextFieldContainer({Key? key, required this.child, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}