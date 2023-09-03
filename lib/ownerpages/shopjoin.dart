import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/Widgets/margintextinputwidget.dart';
import 'package:offline/ownerpages/ownerhome.dart';
import 'package:offline/ownerpages/ownermain.dart';
import 'package:offline/utils/common/get-owner-info.dart';

import '../Widgets/roundedInputField.dart';
import '../userpages/signup.dart';

class ShopJoinPage extends StatefulWidget {
  const ShopJoinPage({Key? key}) : super(key: key);

  @override
  State<ShopJoinPage> createState() => _ShopJoinPageState();
}

class _ShopJoinPageState extends State<ShopJoinPage> {
  final shopJoinformKey = GlobalKey<FormState>();

  final PageController _pageController = PageController(initialPage: 0);

  Map<String, TextEditingController> merchantControllers = {
    "residentNumber": TextEditingController(),
    "merchantname": TextEditingController(),
    "merchantbirthday": TextEditingController(),
    "id": TextEditingController(),
    "password": TextEditingController(),
    "location": TextEditingController(),
    "phoneNumber": TextEditingController(),
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: shopJoinformKey,
          child: Background(
            child: Container(
              alignment: Alignment.center,
              height: 1000,
              width: 1000,
              child: PageView(
                controller: _pageController,
                children: [
                  ListView(
                    children: [
                      SizedBox(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            marginTextInputWidget(
                              topText: "사업자 등록 번호",
                              controller: merchantControllers["residentNumber"],
                              color: Theme.of(context).colorScheme.tertiary,
                              hintText: "' - '는 생략해주세요.",
                              keyboardType: TextInputType.datetime,
                              fontSize: size.height * 0.02,
                              validator: (val) {
                                return null;
                              },
                              icon: Icons.paste,
                            ),
                            marginTextInputWidget(
                              topText: "대표자 성함",
                              controller: merchantControllers["merchantName"],
                              color: Theme.of(context).colorScheme.tertiary,
                              hintText: "' - '는 생략해주세요.",
                              fontSize: size.height * 0.02,
                              validator: (val) {
                                return null;
                              },
                              icon: Icons.paste,
                            ),
                            marginTextInputWidget(
                              topText: "대표자 생년월일",
                              color: Theme.of(context).colorScheme.tertiary,
                              hintText: "ex)00000000",
                              keyboardType: TextInputType.number,
                              enabled: true,
                              fontSize: size.height * 0.02,
                              validator: (val) {
                                return null;
                              },
                              icon: Icons.lock,
                            ),
                            SizedBox(
                              height: size.width * 0.04,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              height: size.width * 0.15,
                              width: size.width * 0.5,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                ),
                                onPressed: () async {
                                  //사업자 등록 번호 조회 API
                                  final isValid =
                                      shopJoinformKey.currentState!.validate();
                                  if (isValid) {
                                    shopJoinformKey.currentState!.save();
                                    // await getOwnerInfo(
                                    // );
                                  }
                                  Get.to(() => OwnerMainPage());
                                  // checkBusinessRegistration(registration);
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: size.height * 0.019,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        width: size.width * 0.8,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.info,
                              color: Colors.white,
                            ),
                            Text(
                              "매장 정보를 확인해주세요",
                              style: TextStyle(
                                fontSize: size.height * 0.023,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        padding: EdgeInsets.symmetric(
                            vertical: size.height * 0.008,
                            horizontal: size.height * 0.015),
                        width: size.width * 0.9,
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.tertiary,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            shopInfoText(
                                topText: "사업자 등록 번호", text: "123123123"),
                            shopInfoText(topText: "대표자 성명", text: "신승호"),
                            shopInfoText(topText: "개업 일자", text: "1231231"),
                            shopInfoText(topText: "상호", text: "아아아"),
                            shopInfoText(
                                topText: "법인 등록 번호", text: "123123123"),
                            shopInfoText(topText: "주 업태명", text: "안녕하세요"),
                            shopInfoText(topText: "주 공목명", text: "안녕하세요"),
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
                                Theme.of(context).colorScheme.primary,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), //볼더 제거
                            ),
                            shadowColor: Colors.white.withOpacity(0),
                          ),
                          onPressed: () {},
                          child: Text(
                            "다음",
                            style: TextStyle(
                              fontSize: size.height * 0.025,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      marginTextInputWidget(
                        topText: "비밀번호",
                        maxLength: 15,
                        color: Colors.white,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        enabled: true,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          // if (val.isEmpty) {
                          //   return "비밀번호을 입력해주세요.";
                          // }
                          // // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                          // if (specialCharRegexNum.allMatches(val).length < 3) {
                          //   return "숫자 3자 이상 입력해야 합니다.";
                          // }
                          // RegExp specialCharRegex1 = RegExp(r'[ ]');
                          // if (specialCharRegex1.hasMatch(val)) {
                          //   return "공백은 입력할 수 없습니다.";
                          // }
                          return null; // 유효한 값인 경우 null을 반환
                        },
                        icon: Icons.lock,
                      ),
                      marginTextInputWidget(
                        topText: "비밀번호 확인",
                        maxLength: 15,
                        color: Colors.white,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        enabled: true,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          // if (val.isEmpty) {
                          //   return "비밀번호를 재입력해주세요.";
                          // }
                          // if (val != userPasswordCont.text) {
                          //   return "비밀번호를 다시 확인해주세요.";
                          // }
                          return null;
                        },
                        icon: Icons.lock_outline,
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
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(
        vertical: size.height * 0.008,
      ),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(
          vertical: size.height * 0.015, horizontal: size.height * 0.02),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(size.height * 0.015),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            topText,
            style: TextStyle(
              fontSize: size.height * 0.015,
              color: Colors.black38,
            ),
          ),
          const SizedBox(
            height: 6,
          ),
          Text(
            text,
            style: TextStyle(
              fontSize: size.height * 0.019,
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
