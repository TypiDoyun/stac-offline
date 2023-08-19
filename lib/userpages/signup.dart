import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../Widgets/roundedInputField.dart';
import '../servercontroller.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController userNameCont = TextEditingController();
  final TextEditingController userIdCont = TextEditingController();
  final TextEditingController userPasswordCont = TextEditingController();
  final TextEditingController userPhonenumberCont = TextEditingController();
  final TextEditingController userBirthCont = TextEditingController();

  bool _isLoading = false;

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

  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();
  FocusNode _focusNode3 = FocusNode();

  @override
  void dispose() {
    userNameCont.dispose();
    userIdCont.dispose();
    userPasswordCont.dispose();
    _focusNode1.dispose();
    _focusNode2.dispose();
    _focusNode3.dispose();
    super.dispose();
  }

  void test(String value) {
    _focusNode1.unfocus();
    FocusScope.of(context).requestFocus(_focusNode2);
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
          height: size.width * 0.8,
          width: size.width,
          child: Form(
            key: signKey,
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
                    signInputField(
                      controller: userNameCont,
                      focusNode: _focusNode1,
                      topText: "성함",
                      color: Colors.white,
                      hintText: "ex) 홍길동",
                      keyboardType: TextInputType.text,
                      enabled: true,
                      onChanged: (val) {
                        // userInfoInput["userName"] = val;
                      },
                      validator: (val) {
                        return null;
                      },
                      onFieldSubmitted: test,
                      icon: Icons.person_outline,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    signInputField(
                      focusNode: _focusNode2,
                      maxLength: 12,
                      controller: userIdCont,
                      topText: "아이디",
                      color: Colors.white,
                      hintText: "ID",
                      keyboardType: TextInputType.visiblePassword,
                      enabled: true,
                      onChanged: (val) {},
                      validator: (val) {
                        if (val.isEmpty) {
                          return "아이디를 입력해주세요.";
                        }
                        // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                        RegExp specialCharRegex =
                            RegExp(r'[^!@#\$%^&*(),.?":{}|<> ]{6,}');
                        if (!specialCharRegex.hasMatch(val)) {
                          return "특수 문자는 입력할 수 없습니다.";
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
                    if (_isLoading)
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
                      focusNode: _focusNode3,
                      controller: userPasswordCont,
                      topText: "비밀번호",
                      maxLength: 15,
                      color: Colors.white,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      enabled: true,
                      obscureText: true,
                      onChanged: (val) {
                        // userInfoInput["userPassword"] = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "비밀번호을 입력해주세요.";
                        }
                        // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                        if (specialCharRegexNum.allMatches(val).length < 3) {
                          return "숫자 3자 이상 입력해야 합니다.";
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
                        return null; // 유효한 값인 경우 null을 반환
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
                      onChanged: (val) {
                        // userInfoInput["userPhonenumber"] = val;
                      },
                      validator: (val) {
                        if (val.isEmpty) {
                          return "전화번호를 입력해주세요.";
                        }

                        // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                        RegExp specialCharRegex =
                            RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
                        if (specialCharRegex.hasMatch(val)) {
                          return "특수 문자는 입력할 수 없습니다.";
                        }

                        return null; // 유효한 값인 경우 null을 반환
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
                      onChanged: (val) {
                        // userInfoInput["userBirth"] = val;
                      },
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
            if (_currentPage >= 1) // 첫 페이지일 때는 왼쪽 버튼을 표시하지 않음
              IconButton(
                onPressed: _previousPage,
                icon: const Icon(Icons.arrow_back),
              ),
            IconButton(
              onPressed: _nextPage,
              icon: const Icon(Icons.arrow_forward),
            ),
            if (_currentPage > 1)
              InkWell(
                onTap: () {
                  Map userInfo = {
                    "userName": userNameCont.text,
                    "userId": userIdCont.text,
                    "userPassword": userPasswordCont.text,
                    "userPhonenumber": userPhonenumberCont.text,
                    "userBirth": userBirthCont.text
                  };
                  sendUserInfoDataToServer(userInfo);
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
          decoration: InputDecoration(
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
