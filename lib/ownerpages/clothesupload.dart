
import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
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
    "saleValue": 0,
    "time": DateTime.now().toIso8601String(),
  };

  List<XFile> _selectedImages = [];

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(
      imageQuality: 30,
    );

    if (pickedImages != null) {
      setState(() {
        _selectedImages = pickedImages;
      });
    }
  }
  var formData = dio.FormData.fromMap({'images': [dio.MultipartFile.fromFile(_selectedImages[0].path)]});
  // var formData = dio.FormData.fromMap({'image': dio.MultipartFile.fromBytes(_selectedImages)});


  Future<dynamic> patchUserProfileImage(String baseUri, dynamic input) async {
    print("프로필 사진을 서버에 업로드 합니다.");
    var dio = new Dio();
    try {
      dio.options.contentType = 'multipart/form-data';
      dio.options.maxRedirects.isFinite;

      var response = await dio.post(
        baseUri + '/clothes',
        data: input,
      );
      print('성공적으로 업로드했습니다');
      return response.data;
    } catch (e) {
      print(e);
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
                  validator: (val) {
                    return null;
                  },
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
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.tag),
              roundedInputField(
                  hintText: "코멘트",
                  keyboardType: TextInputType.text,
                  onSaved: (val) {
                    clothesInfo["comment"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.comment),
              roundedInputField(
                  hintText: "가격",
                  keyboardType: TextInputType.number,
                  onSaved: (val) {
                    clothesInfo["price"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.price_change),
              roundedInputField(
                  hintText: "세일적용가",
                  keyboardType: TextInputType.number,
                  onSaved: (val) {
                    clothesInfo["saleValue"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.discount),
              ElevatedButton(onPressed: _pickImages, child: Text("이미지 선택")),
              // Column(
              //   children: _selectedImages.map((image) {
              //     return Image.asset(
              //       image.path,
              //       width: 200,
              //       height: 200,
              //     );
              //   }).toList(),
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
            sendClothesDataToServer(clothesInfo);
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
