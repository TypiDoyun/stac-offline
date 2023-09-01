import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class marginTextInputWidget extends StatelessWidget {
  final String hintText, topText;
  final FormFieldValidator validator;
  final IconData icon;
  final Color color;
  final double fontSize;
  final bool obscureText = false;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? enabled;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final String? counterText;
  final List<TextInputFormatter>? inputFomatters;

  marginTextInputWidget({
    Key? key,
    required this.color,
    required this.hintText,
    required this.validator,
    required this.icon,
    required this.topText,
    required this.fontSize,
    required this.obscureText,
    this.keyboardType,
    this.enabled,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.counterText,
    this.inputFomatters,
    this.maxLength,
  }) : super(key: key);

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
              errorStyle: TextStyle(
                color: Colors.black38,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
