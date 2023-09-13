import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/Widgets/margintextinputwidget.dart';
import 'package:offline/classes/shop.dart';
import 'package:offline/ownerpages/ownermain.dart';
import 'package:http/http.dart' as http;
import 'package:offline/utils/auth/joinshop.dart';

import '../servercontroller.dart';

class ShopJoinPage extends StatefulWidget {
  const ShopJoinPage({Key? key}) : super(key: key);

  @override
  State<ShopJoinPage> createState() => _ShopJoinPageState();
}

class _ShopJoinPageState extends State<ShopJoinPage> {
  final shopJoinformKey = GlobalKey<FormState>();

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  Map<String, TextEditingController> merchantControllers = {
    "residentNumber": TextEditingController(),
    "merchantname": TextEditingController(),
    "merchantbirthday": TextEditingController(),
    "id": TextEditingController(),
    "password": TextEditingController(),
    "location": TextEditingController(),
    "phoneNumber": TextEditingController(),
  };

  bool isLoading = false;

  Future<void> checkUserId(String data) async {
    try {
      final response = await http.post(
        Uri.parse('${dotenv.env["SERVER_URL"]}/auth/exists'),
        // 서버의 엔드포인트 URL로 변경
        body: {
          'id': data,
        },
      );

      if (response.statusCode == 201) {
        setState(() {
          print("good");
          checkId = json.decode(response.body);
        });
      } else {
        print('Failed to send data. Error code: ${response.statusCode}');
        print('Failed to send data. Error code: ${response.body}');
      }
    } catch (e) {
      print('Error while sending data: $e');
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

  RegExp specialCharRegexNum = RegExp(r'[0-9]');

  final TextEditingController ownerNameCont = TextEditingController();
  final TextEditingController ownerIdCont = TextEditingController();
  final TextEditingController ownerPasswordCont = TextEditingController();
  final TextEditingController ownerPhonenumberCont = TextEditingController();
  final TextEditingController ownerBirthCont = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .background,
        elevation: 0.0,
        toolbarHeight: size.height * 0.07,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Form(
          key: shopJoinformKey,
          child: Background(
            child: Container(
              alignment: Alignment.center,
              child: PageView(
                controller: _pageController,
                children: [
                  ListView(
                    children: [
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            MarginTextInputWidget(
                              topText: "사업자 등록 번호",
                              controller: merchantControllers["residentNumber"],
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              hintText: "' - '는 생략해주세요.",
                              keyboardType: TextInputType.datetime,
                              fontSize: size.height * 0.02,
                              validator: (val) {
                                return null;
                              },
                              icon: Icons.paste,
                            ),
                            MarginTextInputWidget(
                              topText: "대표자 성함",
                              controller: merchantControllers["merchantname"],
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              hintText: "' - '는 생략해주세요.",
                              fontSize: size.height * 0.02,
                              validator: (val) {
                                return null;
                              },
                              icon: Icons.paste,
                            ),
                            MarginTextInputWidget(
                              topText: "대표자 생년월일",
                              controller:
                              merchantControllers["merchantbirthday"],
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              hintText: "ex)00000000",
                              keyboardType: TextInputType.number,
                              enabled: true,
                              fontSize: size.height * 0.02,
                              validator: (val) {
                                return null;
                              },
                              icon: Icons.lock,
                            ),
                            MarginTextInputWidget(color: Theme
                                .of(context)
                                .colorScheme
                                .onSecondaryContainer,
                                hintText: "정확하게 입력해주세요.",
                                validator: (val) {return null;},
                                icon: Icons.location_on,
                                topText: "사업지 주소",
                                fontSize: size.height * 0.2,),
                            SizedBox(
                              height: size.width * 0.04,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              height: size.width * 0.15,
                              width: size.width * 0.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(50), //볼더 제거
                                  ),
                                  shadowColor: Colors.white.withOpacity(0),
                                  backgroundColor: Theme
                                      .of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                ),
                                onPressed: () async {
                                  //사업자 등록 번호 조회 API
                                  final isValid =
                                  shopJoinformKey.currentState!.validate();
                                  if (isValid) {
                                    shopJoinformKey.currentState!.save();
                                    print(
                                        merchantControllers["merchantbirthday"]!
                                            .text);
                                    await sendShopInfoDataToServer(
                                      merchantControllers["residentNumber"]!
                                          .text,
                                      merchantControllers["merchantname"]!.text,
                                      merchantControllers["merchantbirthday"]!
                                          .text,
                                    ) != null ? print("굿") : Get.snackbar("다시 확인", "해주세요");
                                    // Shop newShop = Shop(
                                    //     name: "",
                                    //     shopNumber: "",
                                    //     logo: "",
                                    //     registrationNumber: merchantControllers["residentNumber"]!.text);
                                  }
                                },
                                child: Text(
                                  "매장 조회하기",
                                  style: TextStyle(
                                    fontSize: size.height * 0.02,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.019,
                        ),
                        decoration: BoxDecoration(
                          color:
                          Theme
                              .of(context)
                              .colorScheme
                              .tertiaryContainer,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            SizedBox(width: size.width * 0.03,),
                            Text(
                              "매장 정보를 확인해주세요",
                              style: TextStyle(
                                fontFamily: "NotoSansKR",
                                fontSize: size.height * 0.02,
                                fontWeight: FontWeight.bold,
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .secondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: 20, vertical: size.height * 0.02),
                        padding: EdgeInsets.symmetric(
                          horizontal: size.height * 0.015,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Theme
                                    .of(context)
                                    .colorScheme
                                    .primaryContainer,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12.withOpacity(0.1),
                                    spreadRadius: 1,
                                    blurRadius: 15,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  shopInfoText(
                                      topText: "사업자 등록 번호", text: "123123123"),
                                  shopInfoText(topText: "대표자 성명", text: "신승호"),
                                  shopInfoText(
                                      topText: "사업장 주소",
                                      text: "경기도 용인시 처인구 고림동"),
                                  shopInfoText(
                                      topText: "개업 일자", text: "1231231"),
                                  shopInfoText(topText: "상호", text: "아아아"),
                                  shopInfoText(
                                      topText: "법인 등록 번호", text: "123123123"),
                                  shopInfoText(topText: "주 업태명", text: "안녕하세요"),
                                  shopInfoText(topText: "주 공목명", text: "안녕하세요"),
                                ],
                              ),
                            )
                            //
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: size.width * 0.14,
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Theme
                                .of(context)
                                .colorScheme
                                .tertiaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), //볼더 제거
                            ),
                            shadowColor: Colors.white.withOpacity(0),
                          ),
                          onPressed: () {},
                          child: Text(
                            "다음",
                            style: TextStyle(
                              fontFamily: "NotoSansKR",
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MarginTextInputWidget(
                        controller: ownerNameCont,
                        topText: "성함",
                        color:
                        Theme
                            .of(context)
                            .colorScheme
                            .onSecondaryContainer,
                        hintText: "Nickname",
                        counterText: '',
                        maxLength: 4,
                        fontSize: size.height * 0.015,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "성함을 입력해주세요";
                          }
                          return null;
                        },
                        icon: Icons.person_outline,
                      ),
                      MarginTextInputWidget(
                        maxLength: 12,
                        controller: ownerIdCont,
                        topText: "아이디",
                        color:
                        Theme
                            .of(context)
                            .colorScheme
                            .onSecondaryContainer,
                        hintText: "ID",
                        keyboardType: TextInputType.visiblePassword,
                        fontSize: size.height * 0.02,
                        inputFomatters: [
                          FilteringTextInputFormatter(
                            RegExp('[a-z A-Z 0-9]'),
                            allow: true,
                          )
                        ],
                        validator: (val) {
                          if (val.isEmpty) {
                            return "6~12글자로 입력해주세요";
                          }
                          // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                          RegExp specialCharRegex =
                          RegExp(r'[^!@#\$%^&*(),.?":{}|<> ]');
                          if (!specialCharRegex.hasMatch(val)) {
                            return "특수 문자와 공백은 입력할 수 없습니다.";
                          }
                          if (val.length < 6) {
                            return "최소 6자 이상 입력해야합니다.";
                          }
                          if (specialCharRegexNum
                              .allMatches(val)
                              .isEmpty) {
                            return "숫자 1자 이상 입력해야 합니다.";
                          }
                          return null;
                        },
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: size.width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Theme
                                .of(context)
                                .colorScheme
                                .tertiaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50), //볼더 제거
                            ),
                            shadowColor: Colors.white.withOpacity(0),
                          ),
                          onPressed: () async {
                            await checkUserId(ownerIdCont.text);
                            print(checkId);
                            if (!checkId!) {
                              _nextPage();
                              checkId = null;
                            }
                          },
                          child: Text(
                            "중복 확인",
                            style: TextStyle(fontSize: size.height * 0.015),
                          ),
                        ),
                      ),
                      if (isLoading)
                        const Text("확인중..")
                      else
                        if (checkId != null)
                          checkId!
                              ? const Text("이미 사용중인 아이디 입니다.")
                              : const Text("사용 가능한 아이디 입니다.")
                        else
                          const SizedBox(),
                    ],
                  ),
                  Column(
                    children: [
                      MarginTextInputWidget(
                        controller: ownerPasswordCont,
                        topText: "비밀번호",
                        maxLength: 15,
                        color:
                        Theme
                            .of(context)
                            .colorScheme
                            .onSecondaryContainer,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        enabled: true,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "비밀번호을 입력해주세요.";
                          }
                          // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                          if (specialCharRegexNum
                              .allMatches(val)
                              .length < 3) {
                            return "숫자 3자 이상 입력해야 합니다.";
                          }
                          RegExp specialCharRegex1 = RegExp(r'[ ]');
                          if (specialCharRegex1.hasMatch(val)) {
                            return "공백은 입력할 수 없습니다.";
                          }
                          return null; // 유효한 값인 경우 null을 반환
                        },
                        icon: Icons.lock,
                      ),
                      MarginTextInputWidget(
                        topText: "비밀번호 확인",
                        maxLength: 15,
                        color:
                        Theme
                            .of(context)
                            .colorScheme
                            .onSecondaryContainer,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        enabled: true,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "비밀번호를 재입력해주세요.";
                          }
                          if (val != ownerPasswordCont.text) {
                            return "비밀번호를 다시 확인해주세요.";
                          }
                          return null;
                        },
                        icon: Icons.lock_outline,
                      ),
                      SizedBox(height: 20),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: size.width * 0.14,
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                            Theme
                                .of(context)
                                .colorScheme
                                .tertiaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), //볼더 제거
                            ),
                            shadowColor: Colors.white.withOpacity(0),
                          ),
                          onPressed: () {
                            Get.offAll(OwnerMainPage());
                          },
                          child: Text(
                            "가입하기",
                            style: TextStyle(
                              color: Theme
                                  .of(context)
                                  .colorScheme
                                  .secondary,
                              fontSize: size.height * 0.02,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  shopInfoText({required String text, topText}) {
    Size size = MediaQuery
        .of(context)
        .size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.002,
      ),
      width: MediaQuery
          .of(context)
          .size
          .width,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.01, horizontal: size.height * 0.02),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.height * 0.015),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topText,
            style: TextStyle(
              fontSize: size.height * 0.012,
              color: Colors.black38,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: size.height * 0.015,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

// class BusinessRegistration {
//   String registrationNumber;
//   String registrationDate;
//   List<String> presidents;
//   String businessName;
//   String corpNumber;
//   String businessSector;
//   String businessType;
//   String businessAddress;
//
//   BusinessRegistration(
//       this.registrationNumber,
//       this.registrationDate,
//       this.presidents,
//       this.businessName,
//       this.corpNumber,
//       this.businessSector,
//       this.businessType,
//       this.businessAddress);
// }
//
// const String businessmanServiceKey =
//     "55vkrgaOLK%2F6YNyRpD4WGnGROVFAepA%2BctN2zrY%2FkZasPPUCIWkIHNgfGKhoWnUic8uzh08ZdfwBFwwY9zz%2FJQ%3D%3D";
// const String businessmanUrl =
//     "https://api.odcloud.kr/api/nts-businessman/v1/validate";
//
// Future<bool> checkBusinessRegistration(
//     BusinessRegistration registration) async {
//   print(registration.presidents);
//   final body = json.encode({
//     "businesses": [
//       {
//         "b_no": "0000000000",
//         "start_dt": "20000101",
//         "p_nm": "홍길동",
//         "p_nm2": "홍길동",
//         "b_nm": "(주)테스트",
//         "corp_no": "0000000000000",
//         "b_sector": "",
//         "b_type": "",
//         "b_adr": ""
//       }
//     ]
//   });
//
//   try {
//     final response = await http.post(
//         Uri.parse("$businessmanUrl?serviceKey=$businessmanServiceKey"),
//         body: body);
//     print(response.body);
//     final data = json.decode(response.body);
//     // print(response[0]["b_no"]);
//     // if (response["status_code"] != "OK") return false;
//     // if (response["data"][0]["valid"] == "02") return false;
//     // print("respons: $response");
//   } catch (error) {
//     print('Error while sending data: $error');
//   }
//
//   return true;
// }
