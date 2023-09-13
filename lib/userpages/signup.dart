import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:offline/Widgets/background.dart';
import 'package:offline/userpages/usermain.dart';

import '../Widgets/User.dart';
import '../Widgets/TextFieldContainer.dart';
import '../Widgets/margintextinputwidget.dart';
import '../ownerpages/ownermain.dart';
import '../servercontroller.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userNameCont = TextEditingController();
  final TextEditingController userIdCont = TextEditingController();
  final TextEditingController userPasswordCont = TextEditingController();
  final TextEditingController userPhonenumberCont = TextEditingController();
  final TextEditingController userBirthCont = TextEditingController();

  bool isLoading = false;

  final signKey = GlobalKey<FormState>();

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

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

  bool containsOnlyVowelsOrConsonants(String value) {
    // 정규식을 사용하여 입력값이 자음 또는 모음으로만 이루어져 있는지 확인
    final regex = RegExp(r'^[aeiou]+$|^[bcdfghjklmnpqrstvwxyz]+$');
    return regex.hasMatch(value);
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

  ////

  RegExp specialCharRegexNum = RegExp(r'[0-9]');

  Future<void> checkUserId(String data) async {
    try {
      final response = await http.post(
        Uri.parse('/auth/exists'), // 서버의 엔드포인트 URL로 변경
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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: Background(
        child: ListView(children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: size.width * 0.08),
            child: Center(
              child: Text(
                "회원가입",
                style: TextStyle(
                    fontSize: size.height * 0.02, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          SizedBox(
            height: size.width,
            width: size.width,
            child: Form(
              key: signKey,
              child: PageView(
                // physics: NeverScrollableScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: [
                  Column(
                    children: [
                      MarginTextInputWidget(
                        controller: userNameCont,
                        topText: "성함",
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        hintText: "Nickname",
                        counterText: '',
                        maxLength: 4,
                        fontSize: size.height * 0.015,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "성함을 입력해주세요";
                          }
                          if (containsOnlyVowelsOrConsonants(val)) {
                            return "다시 한번 확인해주세요.";
                          }
                          return null;
                        },
                        icon: Icons.person_outline,
                      ),
                      MarginTextInputWidget(
                        maxLength: 12,
                        controller: userIdCont,
                        topText: "아이디",
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
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
                          if (specialCharRegexNum.allMatches(val).isEmpty) {
                            return "숫자 1자 이상 입력해야 합니다.";
                          }
                          return null;
                        },
                        icon: Icons.person,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: size.width * 0.3,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50), //볼더 제거
                            ),
                            shadowColor: Colors.white.withOpacity(0),
                          ),
                          onPressed: () async {
                            await checkUserId(userIdCont.text);
                            print(checkId);
                            if (!checkId!) {
                              _nextPage();
                              checkId = null;
                            }
                          },
                          child: const Text(
                            "중복 확인",
                            style: TextStyle(fontSize: 12),
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
                        controller: userPasswordCont,
                        topText: "비밀번호",
                        maxLength: 15,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "비밀번호을 입력해주세요.";
                          }
                          // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                          if (specialCharRegexNum.allMatches(val).length < 3) {
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
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        hintText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "비밀번호를 재입력해주세요.";
                          }
                          if (val != userPasswordCont.text) {
                            return "비밀번호를 다시 확인해주세요.";
                          }
                          return null;
                        },
                        icon: Icons.lock_outline,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      MarginTextInputWidget(
                        controller: userPhonenumberCont,
                        topText: "전화번호",
                        maxLength: 11,
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        hintText: "ex) 01012345678",
                        keyboardType: TextInputType.number,
                        enabled: true,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          if (val.isEmpty) {
                            return "전화번호를 입력해주세요.";
                          }
                          RegExp specialCharRegex =
                              RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
                          if (specialCharRegex.hasMatch(val)) {
                            return "특수 문자는 입력할 수 없습니다.";
                          }
                          return null;
                        },
                        icon: Icons.phone,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      MarginTextInputWidget(
                        controller: userBirthCont,
                        topText: "생년월일",
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        hintText: "ex) 950106",
                        keyboardType: TextInputType.number,
                        fontSize: size.height * 0.02,
                        validator: (val) {
                          return null;
                        },
                        icon: Icons.cake,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: size.width * 0.14,
                        width: size.width * 0.8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                Theme.of(context).colorScheme.tertiaryContainer,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30), //볼더 제거
                            ),
                            shadowColor: Colors.white.withOpacity(0),
                          ),
                          onPressed: () async {
                            final isValid = signKey.currentState!.validate();
                            if (isValid) {
                              User newUser = User(
                                id: userNameCont.text,
                                username: userIdCont.text,
                                password: userPasswordCont.text,
                                phoneNumber: userPhonenumberCont.text,
                                birthday: userBirthCont.text,
                              );
                              sendUserInfoDataToServer(newUser);
                              Get.offAll(const UserMain());
                            }
                            Get.snackbar("다시 한번 확인해주세요", "잘못 입력된 부분이 있어요.",);
                          },
                          child: Text(
                            "회원가입",
                            style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary,
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
          if (_currentPage >= 1)
            IconButton(
              onPressed: _previousPage,
              icon: const Icon(Icons.arrow_back),
            ),
          const SizedBox(
            height: 50,
          ),
        ]),
      ),
    );
  }
}

//네이버 문자인증 API
// Future getSignature(String serviceId, String timeStamp, String accessKey,
//     String secretKey) {
//   var space = " "; // one space
//   var newLine = "\n"; // new line
//   var method = "POST"; // method
//   var url = "/sms/v2/services/$serviceId/messages";
//
//   var buffer = new StringBuffer();
//   buffer.write(method);
//   buffer.write(space);
//   buffer.write(url);
//   buffer.write(newLine);
//   buffer.write((DateTime
//       .now()
//       .millisecondsSinceEpoch).toString());
//   buffer.write(newLine);
//   buffer.write(accessKey);
//   print(buffer.toString());
//
//   /// signing key
//   var key = utf8.encode(secretKey);
//   var signingKey = new Hmac(sha256, key);
//
//   var bytes = utf8.encode(buffer.toString());
//   var digest = signingKey.convert(bytes);
//   String signatureKey = base64.encode(digest.bytes);
//   return signatureKey;
// }
//
// void sendSMS(String phoneNumber) async {
//   Map data = {
//     "type": "SMS",
//     "contentType": "COMM",
//     "countryCode": "82",
//     "from": "1234567890",
//     "content": "ABCD",
//     "messages": [
//       {
//         "to": phoneNumber,
//         "content": "EFGH",
//       }
//     ],
//   };
//   var result = await http.post(
//       "https://sens.apigw.ntruss.com/sms/v2/services/${Uri.encodeComponent(
//           'SecretKey')}/messages",
//       headers: <String, String>{
//         "accept": "application/json",
//         'content-Type': 'application/json; charset=UTF-8',
//         'x-ncp-apigw-timestamp': (DateTime
//             .now()
//             .millisecondsSinceEpoch).toString(),
//         'x-ncp-iam-access-key': AccessKey,
//         'x-ncp-apigw-signature-v2': getSignature(
//             Uri.encodeComponent(OpenAPIKey - ID), timeStamp,
//             AccessKey, SecretKey)
//       },
//       body: json.encode(data)
//   );
//   print(result.body);
// }
