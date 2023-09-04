import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OwnerClothesListItem extends StatelessWidget {
  const OwnerClothesListItem({
    Key? key,
    required this.clothesName,
    required this.clothesPrice,
    required this.clothesSize,
    required this.clothesComment,
    required this.onPressedDelete,
    this.clothesImage, required this.onTap,
  }) : super(key: key);

  final String clothesName, clothesSize, clothesComment;
  final int clothesPrice;
  final dynamic clothesImage, onPressedDelete, onTap;


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      child: ListTile(
        onTap: () {
          onTap();
        },
        leading: Container(height: 120, width: 120, color: Colors.black,),
        title: Text(clothesName),
        subtitle: Text(clothesPrice.toString()),
        trailing: IconButton(icon: Icon(Icons.delete), onPressed: () {onPressedDelete;},
        ),
      ),
    );

    // InkWell(
    //   onTap: () {
    //     onTap();
    //   },
    //   child: Container(
    //     alignment: Alignment.center,
    //     child: Row(
    //       children: [
    //         Container(
    //           color: Colors.black,
    //           height: 120,
    //           width: 120,
    //         ),
    //         Container(
    //           padding: const EdgeInsets.symmetric(horizontal: 10),
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.start,
    //             children: [
    //               Text(
    //                 clothesName,
    //                 style: TextStyle(fontSize: 13),
    //               ),
    //               const SizedBox(
    //                 height: 13,
    //               ),
    //               Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: [
    //                   Text(
    //                     clothesSize,
    //                     style: TextStyle(fontSize: 10),
    //                   ),
    //                   Text(
    //                     clothesComment,
    //                     style: TextStyle(fontSize: 10),
    //                   ),
    //                   Text(
    //                     clothesPrice.toString(),
    //                     style: TextStyle(fontSize: 10),
    //                   ),
    //                 ],
    //               ),
    //             ],
    //           ),
    //         ),
    //         Container(
    //           padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    //             crossAxisAlignment: CrossAxisAlignment.center,
    //             children: [
    //               IconButton(
    //                 icon: Icon(Icons.delete),
    //                 onPressed: () {
    //                   onPressedDelete;
    //                 },
    //               ),
    //             ],
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}