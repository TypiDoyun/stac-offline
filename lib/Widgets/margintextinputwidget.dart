import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

marginTextInputWidget({
  required String hintText,
  required FormFieldValidator validator,
  required IconData icon,
  required Color color,
  required String topText,
  TextInputType? keyboardType,
  bool? enabled,
  TextEditingController? controller,
  int? maxLength,
  bool obscureText = false,
  Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  FocusNode? focusNode,
  String? counterText,
  List<TextInputFormatter>? inputFomatters,
}) {
  return TextFieldContainer(
    color: color,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                topText,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: keyboardType,
          enabled: enabled,
          obscureText: obscureText,
          inputFormatters: inputFomatters,
          decoration: InputDecoration(
            counterText: counterText,
            icon: Icon(icon),
            hintText: hintText,
            border: InputBorder.none,
            errorStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
}
class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final Color color;

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
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 15),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
