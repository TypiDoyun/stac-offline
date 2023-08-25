import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Widgets/User.dart';
import '../Widgets/roundedInputField.dart';
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

////
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

  FocusNode focusNode1 = FocusNode();
  FocusNode focusNode2 = FocusNode();
  FocusNode focusNode3 = FocusNode();

  @override
  void dispose() {
    userNameCont.dispose();
    userIdCont.dispose();
    userPasswordCont.dispose();
    focusNode1.dispose();
    focusNode2.dispose();
    focusNode3.dispose();
    super.dispose();
  }

  void test(String value) {
    focusNode1.unfocus();
    FocusScope.of(context).requestFocus(focusNode2);
  }

  Future<void> checkUserId(String data) async {
    try {
      final response = await http.post(
        Uri.parse('$serverUrl_2/auth/exists'), // 서버의 엔드포인트 URL로 변경
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
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: ListView(children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: size.width * 0.08),
          child: const Center(
            child: Text(
              "회원가입",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                    signInputField(
                      controller: userNameCont,
                      focusNode: focusNode1,
                      topText: "닉네임",
                      color: Colors.white,
                      hintText: "Nickname",
                      counterText: '',
                      keyboardType: TextInputType.text,
                      maxLength: 8,
                      enabled: true,
                      inputFomatters: [
                        FilteringTextInputFormatter(
                            RegExp('[a-z A-Zㄱ-ㅎ|가-힣|·|：]'),
                            allow: true)
                      ],
                      onChanged: (val) {
                        // userInfoInput["userName"] = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "닉네임을 입력해주세요.";
                        }
                        if (val.length < 3) {
                          return "3글자 이상 입력해주세요.";
                        }
                        return null;
                      },
                      onFieldSubmitted: test,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    signInputField(
                      focusNode: focusNode2,
                      maxLength: 12,
                      controller: userIdCont,
                      topText: "아이디",
                      color: Colors.white,
                      hintText: "ID",
                      keyboardType: TextInputType.visiblePassword,
                      enabled: true,
                      inputFomatters: [
                        FilteringTextInputFormatter(
                          RegExp('[a-z A-Z 0-9]'),
                          allow: true,
                        )
                      ],
                      validator: (val) {
                        if (val.isEmpty) {
                          return "아이디를 입력해주세요.";
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
                    SizedBox(
                      height: size.width * 0.08,
                    ),
                    SizedBox(
                      width: size.width * 0.3,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, //볼더 제거
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
                    signInputField(
                      focusNode: focusNode3,
                      controller: userPasswordCont,
                      topText: "비밀번호",
                      maxLength: 15,
                      color: Colors.white,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      enabled: true,
                      obscureText: true,
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
                    signInputField(
                      topText: "비밀번호 확인",
                      maxLength: 15,
                      color: Colors.white,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      enabled: true,
                      obscureText: true,
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
                    signInputField(
                      controller: userPhonenumberCont,
                      topText: "전화번호",
                      maxLength: 11,
                      color: Colors.white,
                      hintText: "ex) 01012345678",
                      keyboardType: TextInputType.number,
                      enabled: true,
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
                    signInputField(
                      controller: userBirthCont,
                      topText: "생년월일",
                      color: Colors.white,
                      hintText: "ex) 950106",
                      keyboardType: TextInputType.number,
                      enabled: true,
                      validator: (val) {
                        return null;
                      },
                      icon: Icons.cake,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_currentPage >= 1)
              IconButton(
                onPressed: _previousPage,
                icon: const Icon(Icons.arrow_back),
              ),
            if (_currentPage > 1)
              InkWell(
                onTap: () async {
                  User newUser = User(
                    id: userNameCont.text,
                    username: userIdCont.text,
                    password: userPasswordCont.text,
                    phoneNumber: userPhonenumberCont.text,
                    birthday: userBirthCont.text,
                  );
                  sendUserInfoDataToServer(newUser);
                },
                child: const Text("회원가입"),
              ),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
      ]),
    );
  }
}

signInputField({
  required String hintText,
  required TextInputType keyboardType,
  required FormFieldValidator validator,
  required IconData icon,
  required bool enabled,
  required Color color,
  required String topText,
  TextEditingController? controller,
  int? maxLength,
  bool obscureText = false,
  Function(String)? onChanged,
  void Function(String)? onFieldSubmitted,
  FocusNode? focusNode,
  String? counterText,
  List<TextInputFormatter>? inputFomatters,
}) {
  return TextFieldContainer(
    color: color,
    child: Column(
      children: [
        Row(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Text(
                topText,
                style: const TextStyle(fontSize: 12),
              ),
            ),
          ],
        ),
        TextFormField(
          onFieldSubmitted: onFieldSubmitted,
          focusNode: focusNode,
          maxLength: maxLength,
          maxLengthEnforcement: MaxLengthEnforcement.enforced,
          controller: controller,
          onChanged: onChanged,
          validator: validator,
          autovalidateMode: AutovalidateMode.always,
          keyboardType: keyboardType,
          enabled: enabled,
          obscureText: obscureText,
          inputFormatters: inputFomatters,
          decoration: InputDecoration(
            counterText: counterText,
            icon: Icon(icon),
            hintText: hintText,
            border: InputBorder.none,
            errorStyle: const TextStyle(
              color: Colors.black38,
              fontSize: 12,
            ),
          ),
        ),
      ],
    ),
  );
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
