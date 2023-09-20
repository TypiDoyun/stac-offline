import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MarginTextInputWidget extends StatelessWidget {
  final String hintText, topText;
  final FormFieldValidator validator;
  final IconData icon;
  final Color color;
  final double fontSize;
  final bool obscureText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? enabled;
  final TextEditingController? controller;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;
  final List<TextInputFormatter>? inputFomatters;

  const MarginTextInputWidget({
    Key? key,
    required this.color,
    required this.hintText,
    required this.validator,
    required this.icon,
    required this.topText,
    required this.fontSize,
    this.keyboardType,
    this.enabled,
    this.controller,
    this.onChanged,
    this.focusNode,
    this.inputFomatters,
    this.maxLength,
    this.obscureText = false,
    this.onFieldSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.005),
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
                margin: EdgeInsets.symmetric(vertical: size.height * 0.007),
                child: Text(
                  topText,
                  style: TextStyle(fontSize: size.height * 0.013),
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
              counterText: "",
              icon: Icon(icon),
              hintText: hintText,
              hintStyle: TextStyle(
                fontSize: size.height * 0.017,
              ),
              border: InputBorder.none,
              errorStyle: TextStyle(
                color: Colors.black38,
                fontSize: size.height * 0.014,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
