import 'package:flutter/material.dart';

class SizeButton extends StatelessWidget {
  const SizeButton(
      {Key? key, required this.toggleTouch, required this.containerColor, required this.borderColor, required this.textColor, required this.text})
      : super(key: key);

  final dynamic toggleTouch;
  final dynamic containerColor;
  final dynamic borderColor;
  final dynamic textColor;
  final dynamic text;


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return InkWell(
      onTap: toggleTouch,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        width: size.width * 0.2,
        height: size.width * 0.1,
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor, width: 1),
        ),
        alignment: Alignment.center,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}
