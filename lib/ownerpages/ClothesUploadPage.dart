import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/roundedInputField.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offline/servercontroller.dart';

class ClothesUploadPage extends StatefulWidget {
  const ClothesUploadPage({super.key});

  @override
  State<StatefulWidget> createState() => _ClothesUploadPageState();
}

class _ClothesUploadPageState extends State<ClothesUploadPage> {
  final formkey = GlobalKey<FormState>();

  final sizeMenus = [
    "Free",
    "XS",
    "S",
    "M",
    "L",
    "XL",
    "2XL",
    "85",
    "90",
    "95",
    "100",
    "105",
    "110"
  ];
  String? selectedSize;

  final Map<String, dynamic> clothesInfo = {
    "name": "",
    "price": 0,
    "size": "",
    "tag": "",
    "comment": "",
    "saleValue" : 0,
    "time" : DateTime.now().toIso8601String();
  };

  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              roundedInputField(
                  hintText: "옷 이름",
                  onSaved: (val) {
                    clothesInfo["name"] = val;
                  },
                  validator: (val) {},
                  keyboardType: TextInputType.text,
                  icon: Icons.abc),
              DropdownButton(
                hint: const Text("Size"),
                value: selectedSize,
                isExpanded: true,
                items: sizeMenus
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        ))
                    .toList(),
                onChanged: (value) => setState(() => selectedSize = value),
              ),
              roundedInputField(
                  hintText: "태그",
                  keyboardType: TextInputType.text,
                  onSaved: (val) {
                    clothesInfo["tag"] = val;
                  },
                  validator: (val) {},
                  icon: Icons.tag),
              roundedInputField(
                  hintText: "코멘트",
                  keyboardType: TextInputType.text,
                  onSaved: (val) {
                    clothesInfo["comment"] = val;
                  },
                  validator: (val) {},
                  icon: Icons.comment),
              roundedInputField(
                  hintText: "가격",
                  keyboardType: TextInputType.number,
                  onSaved: (val) {
                    clothesInfo["price"] = val;
                  },
                  validator: (val) {},
                  icon: Icons.price_change),
              roundedInputField(
                  hintText: "세일적용가",
                  keyboardType: TextInputType.number,
                  onSaved: (val) {
                    clothesInfo["saleValue"] = val;
                  },
                  validator: (val) {},
                  icon: Icons.discount),
              ElevatedButton(onPressed: _pickImage, child: Text("이미지 선택")),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, //볼더 제거
            ),
          ),
          onPressed: () {
            _tryValidation();
            final isValid = formkey.currentState!.validate();
            if (isValid) {
              formkey.currentState!.save();
            }
            sendDataToServer(clothesInfo);
            print(clothesInfo);
            Get.back(result: clothesInfo);
          },
          child: const Text(
            "옷 전시하기!",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      )),
    );
  }

  void _tryValidation() {
    final isValid = formkey.currentState!.validate();
    if (isValid) {
      formkey.currentState!.save();
    }
  }
}
