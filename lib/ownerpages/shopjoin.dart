import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/Widgets/margintextinputwidget.dart';
import 'package:offline/ownerpages/ownermain.dart';
import 'package:http/http.dart' as http;
import 'package:offline/utils/auth/joinshop.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

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

  Map<String, TextEditingController> shopJoinController = {
    "residentNumber": TextEditingController(),
    "shopname": TextEditingController(),
    "merchantname": TextEditingController(),
    "shopbirthday": TextEditingController(),
    "id": TextEditingController(),
    "password": TextEditingController(),
    "phoneNumber": TextEditingController(),
  };
  String shopAddress = "";

  TextEditingController addressController = TextEditingController();
  List list = [];
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
    if (_currentPage < _currentPage + 1) {
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        toolbarHeight: size.height * 0.07,
      ),
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Form(
          key: shopJoinformKey,
          child: Background(
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
                    child: SmoothPageIndicator(
                      controller: _pageController,
                      count: 6,
                      effect: SwapEffect(
                        activeDotColor:
                            Theme.of(context).colorScheme.tertiaryContainer,
                        dotColor: Theme.of(context).colorScheme.onSecondary,
                        dotHeight: size.width * 0.02,
                        dotWidth: size.width * 0.02,
                      ),
                    ),
                  ),
                  Expanded(
                    child: PageView(
                      controller: _pageController,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    width: size.width * 0.8,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: Text(
                                            "Offline은 보세 옷 쇼핑몰 입니다.",
                                            style: TextStyle(
                                              fontSize: size.height * 0.02,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "GmarketSansKR",
                                              letterSpacing: -1.2,
                                            ),
                                          ),
                                        ),
                                        const Text(
                                          "보세 옷가게만 등록이 가능하며,\n브랜드 매장은 등록할 수 없습니다.",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              height: 2,
                                              fontWeight: FontWeight.w400),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.03,
                                        ),
                                        const Text(
                                          "*브랜드 매장 가입 시, 불이익을 받을 수 있습니다.",
                                          style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.red,
                                          ),
                                        ),
                                        // Text("개인정보 동의"),
                                        // 필요한 동의는 생략하였습니다.
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  vertical: size.height * 0.08),
                              height: size.width * 0.14,
                              width: size.width * 0.8,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30), //볼더 제거
                                  ),
                                  shadowColor: Colors.white.withOpacity(0),
                                ),
                                onPressed: () {
                                  _nextPage();
                                },
                                child: Text(
                                  "다음",
                                  style: TextStyle(
                                    fontFamily: "NotoSansKR",
                                    color:
                                        Theme.of(context).colorScheme.secondary,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        ListView(
                          children: [
                            SizedBox(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  MarginTextInputWidget(
                                    topText: "사업자 등록 번호",
                                    controller:
                                        shopJoinController["residentNumber"],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                    hintText: "' - '는 생략해주세요",
                                    keyboardType: TextInputType.datetime,
                                    fontSize: size.height * 0.02,
                                    validator: (val) {
                                      return null;
                                    },
                                    icon: Icons.paste,
                                  ),
                                  MarginTextInputWidget(
                                    controller: shopJoinController["shopname"],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                    hintText: "예시) 꽃동네 옷가게",
                                    validator: (val) {
                                      return null;
                                    },
                                    topText: "가게 이름",
                                    fontSize: size.height * 0.2,
                                    icon: Icons.paste,
                                  ),
                                  MarginTextInputWidget(
                                    topText: "대표자 성함",
                                    controller:
                                        shopJoinController["merchantname"],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                    hintText: "예시) 홍길동",
                                    fontSize: size.height * 0.02,
                                    validator: (val) {
                                      return null;
                                    },
                                    icon: Icons.paste,
                                  ),
                                  MarginTextInputWidget(
                                    topText: "개업 일자",
                                    controller:
                                        shopJoinController["shopbirthday"],
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondaryContainer,
                                    hintText: "예시) 20230924",
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
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    height: size.width * 0.15,
                                    width: size.width * 0.5,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50), //볼더 제거
                                        ),
                                        shadowColor:
                                            Colors.white.withOpacity(0),
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .tertiaryContainer,
                                      ),
                                      onPressed: () async {
                                        print(
                                            "${shopJoinController["residentNumber"]!.text}");
                                        print(
                                            "${shopJoinController["merchantname"]!.text}");
                                        print(
                                            "${shopJoinController["shopbirthday"]!.text}");
                                        if (shopJoinController[
                                                    "residentNumber"]!
                                                .text
                                                .isEmpty ||
                                            shopJoinController["merchantname"]!
                                                .text
                                                .isEmpty ||
                                            shopJoinController["shopbirthday"]!
                                                .text
                                                .isEmpty) {
                                          Get.snackbar(
                                            "다시 한번 확인하세요!",
                                            "비어있는 공간이 있어요",
                                            backgroundColor: Colors.white,
                                            borderColor: Colors.black,
                                            borderWidth: 1,
                                          );
                                        } else {
                                          await authShop(
                                            //사업자 등록 번호 조회 API
                                            shopJoinController[
                                                    "residentNumber"]!
                                                .text,
                                            shopJoinController["merchantname"]!
                                                .text,
                                            shopJoinController["shopbirthday"]!
                                                .text,
                                          )
                                              ? _nextPage()
                                              : Get.snackbar(
                                                  "확인된 사업자 등록 정보가 없어요",
                                                  "정보를 다시한번 확인해주세요",
                                                  backgroundColor: Colors.white,
                                                  borderColor: Colors.black,
                                                  borderWidth: 1,
                                                );
                                        }

                                        // Shop newShop = Shop(
                                        //     name: "",
                                        //     shopNumber: "",
                                        //     logo: "",
                                        //     registrationNumber: shopJoinController["residentNumber"]!.text);
                                      },
                                      child: Text(
                                        "다음",
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
                            MarginTextInputWidget(
                              controller: addressController,
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              hintText: "정확하게 입력해주세요",
                              validator: (val) {
                                return null;
                              },
                              icon: Icons.location_on,
                              topText: "도로명 주소 검색",
                              fontSize: size.height * 0.015,
                            ),
                            IconButton(
                              onPressed: () {
                                Map<String, String> params = {
                                  'confmKey':
                                      'devU01TX0FVVEgyMDIzMDkxNjEyNDc0MjExNDEwODM=',
                                  'currentPage': '1',
                                  'countPerPage': '10',
                                  'keyword': addressController.text,
                                  'resultType': 'json',
                                };
                                http.post(
                                    //주소
                                    Uri.parse(
                                        'https://business.juso.go.kr/addrlink/addrLinkApi.do'),
                                    body: params,
                                    headers: {
                                      'content-type':
                                          'application/x-www-form-urlencoded',
                                    }
                                    //요청 본문
                                    ).then((response) {
                                  var json = jsonDecode(response.body);
                                  setState(() {
                                    list = json['results']['juso'];
                                  });
                                }).catchError((error) {});
                              },
                              icon: const Icon(Icons.search),
                            ),
                            Expanded(
                              child: Container(
                                width: size.width * 0.8,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSecondaryContainer,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: ListView.separated(
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.defaultDialog(
                                          titlePadding: EdgeInsets.only(
                                              top: size.height * 0.02),
                                          title: "매장 주소가 확실한가요?",
                                          titleStyle: TextStyle(
                                              fontSize: size.height * 0.02),
                                          content: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Column(
                                              children: [
                                                Divider(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .tertiaryContainer,
                                                ),
                                                Container(
                                                  margin: const EdgeInsets
                                                      .symmetric(vertical: 10),
                                                  child: Text(
                                                    list[index]['roadAddr'],
                                                    style: TextStyle(
                                                      fontSize:
                                                          size.height * 0.016,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          textCancel: "아니요",
                                          cancelTextColor: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                          textConfirm: "네",
                                          onConfirm: () {
                                            shopAddress =
                                                list[index]['roadAddr'];
                                            Get.back();
                                            print("2");
                                            _nextPage();
                                          },
                                          confirmTextColor: Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          buttonColor: Theme.of(context)
                                              .colorScheme
                                              .tertiaryContainer,
                                        );
                                      },
                                      child: Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8),
                                          decoration: const BoxDecoration(),
                                          child: Text(
                                              "${list[index]['roadAddr']}")),
                                    );
                                  },
                                  separatorBuilder: (context, index) {
                                    return const Divider();
                                  },
                                  itemCount: list.length,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.05,
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                vertical: size.height * 0.019,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(context)
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
                                  SizedBox(
                                    width: size.width * 0.03,
                                  ),
                                  Text(
                                    "매장 정보를 확인해주세요",
                                    style: TextStyle(
                                      fontFamily: "NotoSansKR",
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.bold,
                                      color: Theme.of(context)
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      boxShadow: [
                                        BoxShadow(
                                          color:
                                              Colors.black12.withOpacity(0.1),
                                          spreadRadius: 1,
                                          blurRadius: 15,
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        shopInfoText(
                                            topText: "가게 이름",
                                            text:
                                                shopJoinController["shopname"]!
                                                    .text),
                                        shopInfoText(
                                            topText: "사업자 등록 번호",
                                            text: shopJoinController[
                                                    "residentNumber"]!
                                                .text),
                                        shopInfoText(
                                            topText: "대표자 성명",
                                            text: shopJoinController[
                                                    "merchantname"]!
                                                .text),
                                        shopInfoText(
                                            topText: "사업장 주소",
                                            text: shopAddress),
                                        shopInfoText(
                                            topText: "개업 일자",
                                            text: shopJoinController[
                                                    "shopbirthday"]!
                                                .text),
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
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30), //볼더 제거
                                  ),
                                  shadowColor: Colors.white.withOpacity(0),
                                ),
                                onPressed: () {
                                  _nextPage();
                                },
                                child: Text(
                                  "다음",
                                  style: TextStyle(
                                    fontFamily: "NotoSansKR",
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
                              maxLength: 12,
                              controller: shopJoinController["id"],
                              topText: "아이디",
                              color: Theme.of(context)
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
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(50), //볼더 제거
                                  ),
                                  shadowColor: Colors.white.withOpacity(0),
                                ),
                                onPressed: () async {
                                  await checkUserId(
                                      shopJoinController["id"]!.text);
                                  print(checkId);
                                  if (!checkId!) {
                                    _nextPage();
                                    checkId = null;
                                  }
                                },
                                child: Text(
                                  "중복 확인",
                                  style:
                                      TextStyle(fontSize: size.height * 0.015),
                                ),
                              ),
                            ),
                            if (isLoading)
                              const Text("확인중..")
                            else if (checkId != null)
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
                              controller: shopJoinController["password"],
                              topText: "비밀번호",
                              maxLength: 15,
                              obscureText: true,
                              color: Theme.of(context)
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
                                if (specialCharRegexNum.allMatches(val).length <
                                    3) {
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
                              obscureText: true,
                              color: Theme.of(context)
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
                                if (val !=
                                    shopJoinController["password"]!.text) {
                                  return "비밀번호를 다시 확인해주세요.";
                                }
                                return null;
                              },
                              icon: Icons.lock_outline,
                            ),
                            const SizedBox(height: 20),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              height: size.width * 0.14,
                              width: size.width * 0.8,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(context)
                                      .colorScheme
                                      .tertiaryContainer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(30), //볼더 제거
                                  ),
                                  shadowColor: Colors.white.withOpacity(0),
                                ),
                                onPressed: () {
                                  Get.offAll(const OwnerMainPage());
                                },
                                child: Text(
                                  "가입하기",
                                  style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.secondary,
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
        vertical: size.height * 0.002,
      ),
      width: MediaQuery.of(context).size.width,
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
