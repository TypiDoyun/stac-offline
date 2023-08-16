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

  final sizeMenus_num = [
    "85(XS)",
    "90(S)",
    "95(M)",
    "100(L)",
    "105(XL)",
    "110(2XL)"
  ];

  String? selectedSize1;
  String? selectedSize2;

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

  Future<dynamic> patchUserProfileImage() async {
    if (_selectedImages.length == 0) return;
    var formData = dio.FormData.fromMap({
      "name": "what a fucking shit day!",
      'images': [dio.MultipartFile.fromFileSync(_selectedImages[0].path)]
    });
    // dio.MultipartFile.fromFileSync(_selectedImages[0].path, contentType: MediaType("image", "jpg"))
    print("프로필 사진을 서버에 업로드 합니다.");
    var request = Dio();
    try {
      // request.options.contentType = 'multipart/form-data';
      // request.options.maxRedirects.isFinite;

      var response = await request.post('$serverUrl/clothes',
          data: formData, options: Options(contentType: 'multipart/form-data'));
      print('성공적으로 업로드했습니다');
      return response.data;
    } catch (e) {
      print(e);
    }
  }

  int _textIndex = 0;
  List<String> _textOptions = ['Free', '85(XS) ~ 110(2XL)'];

  void _changeText() {
    setState(() {
      _textIndex = (_textIndex + 1) % _textOptions.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 40,
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
                const SizedBox(
                  height: 30,
                ),
                const Text("버튼을 눌러 사이즈 단위를 선택해주세요!"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _changeText,
                      child: Text(
                        _textOptions[_textIndex],
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    const Text(
                      " Size",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Visibility(
                  visible: _textOptions[_textIndex] == '85(XS) ~ 110(2XL)',
                  child: SizedBox(
                    width: size.width * 0.3,
                    child: Column(
                      children: [
                        DropdownButton(
                          hint: const Text("Size"),
                          value: selectedSize2,
                          isExpanded: true,
                          items: sizeMenus_num
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e),
                                  ))
                              .toList(),
                          onChanged: (value) =>
                              setState(() => selectedSize2 = value),
                        ),
                      ],
                    ),
                  ),
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
                ElevatedButton(
                    onPressed: _pickImages, child: const Text("이미지 선택")),
              ],
            ),
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
              // sendClothesDataToServer(clothesInfo);
              patchUserProfileImage();
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
        ),
      ),
    );
  }

  void _tryValidation() {
    final isValid = formkey.currentState!.validate();
    if (isValid) {
      formkey.currentState!.save();
    }
  }
}
