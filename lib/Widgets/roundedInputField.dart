import 'package:flutter/material.dart';

roundedInputField({
  required String hintText,
  required FormFieldValidator validator,
  required IconData icon,
  required Color color,
  bool? enabled,
  FormFieldSetter? onSaved,
  TextInputType? keyboardType,
  TextEditingController? controller,

  Function(String)? onChanged,
}) {
  return
}

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool obscureText = false;
  final String hintText;
  final FormFieldValidator validator;
  final IconData icon;
  final

  const TextFieldContainer(
      {Key? key,
      required this.child,
      required this.color,
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.003),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFieldContainer(
        color: color,
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
              hintStyle: TextStyle(fontSize: size.)
          ),
        ),
      ),
    );
  }
}
