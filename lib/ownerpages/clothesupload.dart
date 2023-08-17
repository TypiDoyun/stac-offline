import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  int _textIndex = 0;
  List<String> _textOptions = ['Free', '85(XS) ~ 110(2XL)'];

  void _changeText() {
    setState(() {
      _textIndex = (_textIndex + 1) % _textOptions.length;
      if (_textOptions[_textIndex] == 'Free') {
        clothesInfo["size"] = 'Free';
      } else if (_textOptions[_textIndex] == '85(XS) ~ 110(2XL)') {
        clothesInfo["size"] = ['', '', '', '', '', ''];
        List selectedSizes = [];
        for (int i = 0; i < buttonSelectedStates.length; i++) {
          if (buttonSelectedStates[i]) {
            selectedSizes.add(sizeMenus_num[i]);
            clothesInfo["size"][i] = selectedSizes;
          }
        }
      }
    });
  }

  final sizeMenus_num = [
    "85(XS)",
    "90(S)",
    "95(M)",
    "100(L)",
    "105(XL)",
    "110(2XL)",
  ];

  List buttonSelectedStates = List.filled(6, false);

  void _toggleButton(int index) {
    setState(() {
      buttonSelectedStates[index] = !buttonSelectedStates[index];
    });
  }

  final Map<String, dynamic> clothesInfo = {
    "name": "",
    "price": 0,
    "size": 'Free',
    "tag": "",
    "comment": "",
    "saleValue": 0,
    "time": DateTime.now().toIso8601String(),
  };

  bool isCheckboxChecked = false;

  var f = NumberFormat('###,###,###,###,###,###');

  Future<void> _pickImages() async {
    final picker = ImagePicker();
    final pickedImages = await picker.pickMultiImage(
      imageQuality: 30,
    );

    setState(() {
      _selectedImages = pickedImages;
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
                    color: Colors.white,
                    hintText: "옷 이름",
                    enabled: true,
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
                  child: Column(children: [
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: const Text("보유중이신 사이즈를 선택해주세요."),
                    ),
                    ...List.generate(sizeMenus_num.length, (index) {
                      return InkWell(
                        onTap: () {
                          _toggleButton(index);
                          if (buttonSelectedStates[index]) {
                            clothesInfo["size"][index] = sizeMenus_num[index];
                          } else {
                            clothesInfo["size"][index] =
                                ""; // 또는 null을 할당할 수 있습니다.
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          height: size.width * 0.13,
                          width: size.width * 0.26,
                          decoration: BoxDecoration(
                            color: buttonSelectedStates[index]
                                ? Colors.black
                                : Colors.white,
                            borderRadius: BorderRadius.circular(50),
                            border: buttonSelectedStates[index]
                                ? null
                                : Border.all(color: Colors.black, width: 1),
                          ),
                          child: Center(
                            child: Text(
                              sizeMenus_num[index],
                              style: TextStyle(
                                color: buttonSelectedStates[index]
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ]),
                ),
                roundedInputField(
                  color: Colors.white,
                  hintText: "가격",
                  keyboardType: TextInputType.number,
                  enabled: true,
                  onChanged: (val) {
                    setState(() {
                      num parsedValue =
                          double.tryParse(val) ?? 0; // 문자열을 숫자로 변환 (기본값은 0)
                      clothesInfo["price"] = parsedValue;
                    });
                  },
                  onSaved: (val) {
                    num parsedValue =
                        int.tryParse(val) ?? 0; // 문자열을 숫자로 변환 (기본값은 0)
                    clothesInfo["price"] = parsedValue;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.price_change,
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("세일 적용 상품인가요?"),
                      Checkbox(
                        value: isCheckboxChecked,
                        onChanged: (value) {
                          setState(() {
                            isCheckboxChecked = value!;
                            isCheckboxChecked
                                ? null
                                : clothesInfo["saleValue"] = 0;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      roundedInputField(
                          color: isCheckboxChecked
                              ? Colors.black12
                              : Colors.black12.withOpacity(0.4),
                          hintText: "세일 %",
                          keyboardType: TextInputType.number,
                          enabled: isCheckboxChecked,
                          onChanged: (val) {
                            setState(() {
                              num discountValue = double.tryParse(val) ??
                                  0; // 문자열을 숫자로 변환 (기본값은 0)
                              clothesInfo["saleValue"] = discountValue;
                            });
                          },
                          onSaved: (val) {
                            num parsedValue =
                                int.tryParse(val) ?? 0; // 문자열을 숫자로 변환 (기본값은 0)
                            clothesInfo["price"] = parsedValue;
                          },
                          validator: (val) {
                            return null;
                          },
                          icon: Icons.discount),
                      isCheckboxChecked
                          ? Text(
                              '원가 : ${f.format(clothesInfo["price"])}\n세일가 : ${f.format((clothesInfo["price"] - (clothesInfo["price"] * clothesInfo["saleValue"]! / 100)))}',
                              // 저장된 가격 출력, 없을 경우 빈 문자열 출력
                              style: const TextStyle(fontSize: 16),
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                roundedInputField(
                  color: Colors.black12,
                  hintText: "태그",
                  keyboardType: TextInputType.text,
                  enabled: true,
                  onSaved: (val) {
                    clothesInfo["tags"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.tag,
                ),
                roundedInputField(
                  color: Colors.black12,
                  hintText: "코멘트",
                  enabled: true,
                  keyboardType: TextInputType.text,
                  onSaved: (val) {
                    clothesInfo["comment"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.comment,
                ),
                ElevatedButton(
                    onPressed: _pickImages, child: const Text("이미지 선택")),
                SizedBox(
                  height: size.width * 0.8,
                ),
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
                borderRadius: BorderRadius.zero,
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
              print(clothesInfo["name"].runtimeType);
              print(clothesInfo["price"].runtimeType);
              print(clothesInfo["comment"].runtimeType);
              print(clothesInfo["tags"].runtimeType);
              print(clothesInfo["saleValue"].runtimeType);
              print(clothesInfo["time"].runtimeType);
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

List<XFile> _selectedImages = [];

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