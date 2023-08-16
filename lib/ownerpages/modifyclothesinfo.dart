import 'package:flutter/material.dart';
import 'package:offline/Widgets/background.dart';


final imagesList = [
  'assets/images/clothesImage1.jpeg',
  'assets/images/clothesImage2.jpeg',
  'assets/images/clothesImage3.jpeg',
];

class ModityClothesInfo extends StatefulWidget {
  const ModityClothesInfo({Key? key}) : super(key: key);

  @override
  State<ModityClothesInfo> createState() => _ModityClothesInfoState();
}

class _ModityClothesInfoState extends State<ModityClothesInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("한상진"),
      ),
      body: PageView.builder(
          itemCount: imagesList.length,
          itemBuilder: (BuildContext context, int index) {
            return Center(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context)
                    .size
                    .width, // Make the height same as width for a square
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  image: DecorationImage(
                    image: AssetImage(imagesList[index]),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            );
          }),
    );
  }
}
