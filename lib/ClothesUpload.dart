import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class ClothesUpload extends StatefulWidget {
  const ClothesUpload({super.key});

  @override
  State<StatefulWidget> createState() => ClothesUploadState();
}

class ClothesUploadState extends State<ClothesUpload> {
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
  };



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "옷 전시 준비 중...",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Form(
          key: formkey,
          child: ListView(
            children: [
              renderTextFormField(
                label: '옷 이름',
                keyboardType: TextInputType.text,
                onSaved: (val) {
                  clothesInfo["name"] = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '정보를 입력하세요!';
                  }
                  return null;
                },
              ),
              renderTextFormField(
                label: '해시태그',
                keyboardType: TextInputType.text,
                onSaved: (val) {
                  clothesInfo["tag"] = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '정보를 입력하세요!';
                  }
                  return null;
                },
              ),
              DropdownButton<String>(
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
              renderTextFormField(
                label: '가격',
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  clothesInfo["price"] = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '정보를 입력하세요!';
                  }
                  return null;
                },
              ),
              renderTextFormField(
                label: '코멘드',
                keyboardType: TextInputType.text,
                onSaved: (val) {
                  clothesInfo["comment"] = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '정보를 입력하세요!';
                  }
                  return null;
                },
              ),
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

  void _addItemAndReturn(BuildContext context) {
    String itemName = clothesInfo["name"];
    String itemPrice = clothesInfo["price"];

    if (itemName.isNotEmpty && itemPrice.isNotEmpty) {
      Map<String, dynamic> newClothes = {
        'name': itemName,
        'price': int.parse(itemPrice),
      };
      Navigator.pop(context, newClothes);
    }
  }
}


//입력값 위젯
renderTextFormField({
  required String label,
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
  required TextInputType keyboardType,
}) {
  return Column(
    children: [
      Row(
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
      TextFormField(
        onSaved: onSaved,
        validator: validator,
        autovalidateMode: AutovalidateMode.always,
        keyboardType: keyboardType,
      ),
      const SizedBox(
        height: 20,
      ),
    ],
  );


}
