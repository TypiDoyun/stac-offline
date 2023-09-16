import 'package:dio/dio.dart' as dio;
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:offline/Widgets/TextFieldContainer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/servercontroller.dart';

class ClothesUploadPage extends StatefulWidget {
  const ClothesUploadPage({super.key});

  @override
  State<StatefulWidget> createState() => _ClothesUploadPageState();
}

class _ClothesUploadPageState extends State<ClothesUploadPage> {
  final formkey = GlobalKey<FormState>();

  int textIndex = 0;
  List<String> textOptions = ['Free', '85(XS) ~ 110(2XL)'];

  void _changeText() {
    setState(() {
      textIndex = (textIndex + 1) % textOptions.length;
      if (textOptions[textIndex] == 'Free') {
        clothesInfo["size"] = 'Free';
      } else if (textOptions[textIndex] == '85(XS) ~ 110(2XL)') {
        clothesInfo["size"] = ['', '', '', '', '', ''];
        List selectedSizes = [];
        for (int i = 0; i < buttonSelectedStates.length; i++) {
          if (buttonSelectedStates[i]) {
            selectedSizes.add(sizeMenusNum[i]);
            clothesInfo["size"][i] = selectedSizes;
          }
        }
      }
    });
  }

  final sizeMenusNum = [
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
    "comment": "",
    "discountRate": 0,
    "time": DateTime.now().toIso8601String(),
  };

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  bool isCheckboxChecked = false;

  var f = NumberFormat('###,###,###,###,###,###');






  void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentPage--;
      });
    }
  }

  void _nextPage() {
    if (_currentPage < 2) {
      // 총 페이지 수에 따라 조정
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );

      setState(() {
        _currentPage++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Future PickImages() async {
      final picker = ImagePicker();
      final pickedImages = await picker.pickMultiImage(
        imageQuality: 30,
      );

      setState(() {
        _selectedImages = pickedImages;
      });
    }

    Future<void> CameraImages() async {
      final picker = ImagePicker();
      final pickedImages = await picker.getImage(
        source: ImageSource.camera,
        imageQuality: 30,
      );

      setState(() {
        _selectedImages.add(XFile(pickedImages!.path));
      });
    }


    return Scaffold(
      body: Form(
        key: formkey,
        child: Background(
          child: ListView(
            children: [
              SizedBox(
                height: size.height * 0.05,
              ),
              Container(
                height: size.width * 1.3,
                width: size.width,
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (int page) {
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    Column(
                      children: [
                        ClothesUploadTitleWidget(title: "옷의 이름을 작성해주세요"),
                        TextFieldContainer(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          hintText: "옷 이름",
                          enabled: true,
                          onSaved: (val) {
                            clothesInfo["name"] = val;
                          },
                          validator: (val) {
                            return null;
                          },
                          keyboardType: TextInputType.text,
                          icon: Icons.abc,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 15),
                          child: Text(
                            "1+1 이벤트, 옷의 색상, 종류 등\n손님들의 눈길을 사로잡을 정보들을 담는게 좋아요",
                            style: TextStyle(
                                fontSize: size.height * 0.015,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClothesUploadTitleWidget(title: "이미지를 선택해주세요"),
                        SizedBox(height: 8),
                        Container(
                          height: size.height * 0.35,
                          padding: EdgeInsets.symmetric(vertical: size.height * 0.02,),
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _selectedImages.length,
                            itemBuilder: (context, index) {
                              return Stack(
                                children: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 10),
                                      child: Image.file(
                                        File(_selectedImages[index].path),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 5,
                                    right: 15,
                                    child: GestureDetector(
                                      onTap: () {
                                        _removeImage(index);
                                      },
                                      child: CircleAvatar(
                                        radius: 12,
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.close,
                                          color: Theme.of(context)
                                              .colorScheme
                                              .primary,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 18),
                          child: Text(
                            "첫번째로 선택된 사진이\n손님들에게 가장 많이 노출될꺼에요",
                            style: TextStyle(
                                fontSize: 13,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSecondary),
                            textAlign: TextAlign.center,
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: PickImages,
                              child: Column(
                                children: [
                                  Icon(Icons.add_photo_alternate_outlined),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Text("갤러리에서 선택"),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap:  CameraImages,
                              child: Column(
                                children: [
                                  Icon(Icons.add_a_photo_outlined),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  const Text("카메라로 촬영"),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClothesUploadTitleWidget(title: "버튼을 눌러 사이즈 단위를 선택해주세요"),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        InkWell(
                          onTap: _changeText,
                          child: Container(
                            padding: EdgeInsets.only(
                                top: 10, left: 13, right: 13, bottom: 7),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme.of(context)
                                    .colorScheme
                                    .primaryContainer,
                                boxShadow: [
                                  BoxShadow(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary
                                        .withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 15,
                                  ),
                                ]),
                            child: Text(
                              textOptions[textIndex],
                              style: TextStyle(
                                fontSize: 15,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.07,
                        ),
                        Visibility(
                          visible:
                              textOptions[textIndex] == '85(XS) ~ 110(2XL)',
                          child: Column(
                            children: [
                              Container(
                                margin:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  "보유중이신 사이즈를 선택해주세요",
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary),
                                ),
                              ),
                              ...List.generate(
                                sizeMenusNum.length,
                                (index) {
                                  return InkWell(
                                    onTap: () {
                                      _toggleButton(index);
                                      if (buttonSelectedStates[index]) {
                                        clothesInfo["size"][index] =
                                            sizeMenusNum[index];
                                      } else {
                                        clothesInfo["size"][index] =
                                            ""; // 또는 null을 할당할 수 있습니다.
                                      }
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 7),
                                      width: size.width * 0.3,
                                      decoration: BoxDecoration(
                                          color: buttonSelectedStates[index]
                                              ? Colors.black
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .onSecondary
                                                  .withOpacity(0.2),
                                              spreadRadius: 1,
                                              blurRadius: 15,
                                            ),
                                          ]),
                                      child: Center(
                                        child: Text(
                                          sizeMenusNum[index],
                                          style: TextStyle(
                                            fontFamily: "NotoSansKR",
                                            color: buttonSelectedStates[index]
                                                ? Colors.white
                                                : Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClothesUploadTitleWidget(title: "옷의 가격을 입력해주세요"),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        TextFieldContainer(
                          color: Theme.of(context)
                              .colorScheme
                              .onSecondaryContainer,
                          hintText: "가격",
                          keyboardType: TextInputType.number,
                          enabled: true,
                          onChanged: (val) {
                            setState(() {
                              num parsedValue = double.tryParse(val) ?? 0;
                              clothesInfo["price"] = parsedValue;
                            });
                          },
                          onSaved: (val) {
                            num parsedValue = int.tryParse(val) ??
                                0; // 문자열을 숫자로 변환 (기본값은 0)
                            clothesInfo["price"] = parsedValue;
                          },
                          validator: (val) {
                            return null;
                          },
                          icon: Icons.price_change,
                        ),
                        SizedBox(
                          height: size.width * 0.07,
                        ),
                        Container(
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
                                checkColor: Colors.black,
                                value: isCheckboxChecked,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      isCheckboxChecked = value!;
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TextFieldContainer(
                                color: isCheckboxChecked
                                    ? Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer
                                    : Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                hintText: "세일 %",
                                keyboardType: TextInputType.number,
                                enabled: isCheckboxChecked,
                                onChanged: (val) {
                                  setState(
                                    () {
                                      num discountValue =
                                          double.tryParse(val) ??
                                              0; // 문자열을 숫자로 변환 (기본값은 0)
                                      clothesInfo["discountRate"] =
                                          discountValue;
                                    },
                                  );
                                },
                                onSaved: (val) {
                                  // num parsedValue =
                                  //     int.tryParse(val) ?? 0; // 문자열을 숫자로 변환 (기본값은 0)
                                  // clothesInfo["discountRate"] = parsedValue;
                                },
                                validator: (val) {
                                  return null;
                                },
                                icon: Icons.discount),
                            isCheckboxChecked
                                ? Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 20),
                                    width: size.width * 0.5,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondaryContainer
                                          .withOpacity(0.5),
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(10),
                                          bottomRight: Radius.circular(10)),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '원가  ${f.format(clothesInfo["price"])} ₩',
                                          // 저장된 가격 출력, 없을 경우 빈 문자열 출력
                                          style: TextStyle(
                                              fontSize: size.height * 0.015),
                                        ),
                                        Divider(
                                          color: Colors.black,
                                        ),
                                        Text(
                                          '세일가   ${f.format((clothesInfo["price"] - clothesInfo["discountRate"] * (clothesInfo["price"]! / 100)))} ₩',
                                          // 저장된 가격 출력, 없을 경우 빈 문자열 출력
                                          style: TextStyle(
                                            fontSize: size.height * 0.015,
                                            color: Colors.red,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        ClothesUploadTitleWidget(title: "코멘트를 입력해주세요"),
                        SizedBox(
                          height: size.width * 0.01,
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: size.width * 0.05,
                              vertical: size.height * 0.003),
                          width: size.width * 0.8,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            borderRadius: BorderRadius.circular(29),
                          ),
                          child: TextFormField(
                            onChanged: (val) {},
                            onSaved: (val) {},
                            validator: (val) {},
                            autovalidateMode: AutovalidateMode.always,
                            keyboardType: TextInputType.text,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: "이곳에 입력하세요",
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                fontSize: size.height * 0.015,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: size.width * 0.03,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "옷에 대한 정보나 특징 등을\n 매력있게 알려주세요",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Theme.of(context).colorScheme.onSecondary,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (_currentPage >= 1)
                      InkWell(
                          onTap: _previousPage,
                          child: Container(
                            alignment: Alignment.center,
                            height: size.height * 0.08,
                            child: Icon(Icons.arrow_back),
                          )
                      ),
                    if ((_currentPage >= 1) && (_currentPage < 4))
                      SizedBox(width: 10,),
                    if (_currentPage < 4)
                      InkWell(
                      onTap: _nextPage,
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.08,
                        child: Text("다음"),
                      )
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _currentPage == 4
          ? SafeArea(
              child: SizedBox(
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                  ),
                  onPressed: () async {
                    // await _tryValidation();

                    // sendClothesDataToServer(clothesInfo);
                    // patchUserProfileImage();
                    (clothesInfo["size"] as List<String>)
                        .removeWhere((element) => element == "");
                    print(clothesInfo["name"]);
                    print(clothesInfo["price"]);
                    print(clothesInfo["size"]);
                    print(clothesInfo["comment"]);
                    print(clothesInfo["discountRate"]);
                    print(clothesInfo["time"]);
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
            )
          : null,
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
  if (_selectedImages.isEmpty) return;
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

    var response = await request.post('$serverUrl_2/clothes',
        data: formData, options: Options(contentType: 'multipart/form-data'));
    print('성공적으로 업로드했습니다');
    return response.data;
  } catch (e) {
    print(e);
  }
}

class ClothesUploadTitleWidget extends StatelessWidget {
  const ClothesUploadTitleWidget({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: size.height * 0.015),
      child: Text(
        title,
        style: TextStyle(
            fontSize: size.height * 0.02,
            fontWeight: FontWeight.bold,
            color: Theme.of(context)
                .colorScheme
                .tertiaryContainer),
      ),
    );
  }
}

