import 'package:flutter/material.dart';

shopListItem({
  required int index,
  required List shopNameList
}) {
  return Container(
    margin:
    const EdgeInsets.symmetric(vertical: 7, horizontal: 8),
    width: 90,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50),
        ),
        side: const BorderSide(
          color: Colors.black,
          width: 1.0,
        ),
      ),
      onPressed: () {},
      child: Text(
        shopNameList[index],
        style: const TextStyle(color: Colors.black, fontSize: 12),
      ),
    ),
  );
}
