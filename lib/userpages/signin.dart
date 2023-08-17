import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Widgets/roundedInputField.dart';
import '../servercontroller.dart';

class SignPage extends StatelessWidget {
  SignPage({Key? key}) : super(key: key);

  final TextEditingController userNameCont = TextEditingController();
  final TextEditingController userIdCont = TextEditingController();
  final TextEditingController userPasswordCont = TextEditingController();
  final TextEditingController userPhonenumberCont = TextEditingController();
  final TextEditingController userBirthCont = TextEditingController();

  final Map userInfoInput = {
    "userName": "",
    "userId": "",
    "userPassword": "",
    "userPhonenumber": 0,
    "userBirth": 0,
  };

  final signKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: SafeArea(
        child: Center(
            child: Form(
          key: signKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Text(
                  "회원가입",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                signInputField(
                  controller: userNameCont,
                  topText: "성함",
                  color: Colors.white,
                  hintText: "ex) 홍길동",
                  keyboardType: TextInputType.text,
                  enabled: true,
                  onChanged: (val) {
                    userInfoInput["userName"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.person_outline,
                ),
                const SizedBox(
                  height: 10,
                ),
                signInputField(
                  maxLength: 12,
                  controller: userIdCont,
                  topText: "아이디",
                  color: Colors.white,
                  hintText: "ID",
                  keyboardType: TextInputType.visiblePassword,
                  enabled: true,
                  onChanged: (val) {
                    userInfoInput["userId"] = val;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "아이디를 입력해주세요.";
                    }
                    // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                    RegExp specialCharRegex =
                        RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
                    if (specialCharRegex.hasMatch(val)) {
                      return "특수 문자는 입력할 수 없습니다.";
                    }
                    if (checkId) return "이미 사용중인 아이디 입니다.";
                    if (val.length < 6 && val.length > 12)
                      return "아이디는 영문과 숫자 포함 6~12자 까지 사용 가능합니다";
                    return null; // 유효한 값인 경우 null을 반환
                  },
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: size.width * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, //볼더 제거
                      ),
                      shadowColor: Colors.white.withOpacity(0),
                    ),
                    onPressed: () {
                      checkUserId(userInfoInput["userId"]);
                    },
                    child: Text(
                      "중복 확인",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                  width: size.width*0.8,
                  child: Divider(
                    color: Colors.black.withOpacity(0.5), // 선의 색상
                    thickness: 0.7, // 선의 두께
                  ),
                ),
                signInputField(
                  topText: "비밀번호",
                  maxLength: 15,
                  color: Colors.white,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  enabled: true,
                  obscureText: true,
                  onChanged: (val) {
                    userInfoInput["userPassword"] = val;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "비밀번호을 입력해주세요.";
                    }
                    // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                    RegExp specialCharRegex = RegExp(r'[0-9]');
                    if (specialCharRegex.allMatches(val).length < 3) {
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
                    if (val != userInfoInput["userPassword"])
                      return "비밀번호를 다시 확인해주세요.";
                    return null; // 유효한 값인 경우 null을 반환
                  },
                  icon: Icons.lock_outline,
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 10),
                  height: 50,
                  width: size.width*0.8,
                  child: Divider(
                    color: Colors.black.withOpacity(0.5), // 선의 색상
                    thickness: 0.7, // 선의 두께
                  ),
                ),
                signInputField(
                  topText: "전화번호",
                  maxLength: 11,
                  color: Colors.white,
                  hintText: "ex) 01012345678",
                  keyboardType: TextInputType.number,
                  enabled: true,
                  onChanged: (val) {
                    userInfoInput["userPhonenumber"] = val;
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
                  topText: "생년월일",
                  color: Colors.white,
                  hintText: "ex) 950106",
                  keyboardType: TextInputType.number,
                  enabled: true,
                  onChanged: (val) {
                    userInfoInput["userBirth"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.cake,
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    final isValid = signKey.currentState!.validate();
                    if (isValid) {
                      Get.back();
                    }
                    print(userInfoInput);
                    sendUserInfoDataToServer(userInfoInput);
                  },
                  child: const Text("회원가입 하기"),
                ),
              ],
            ),
          ),
        )),
      ),
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
}) {
  return TextFieldContainer(
    color: color,
    child: Column(children: [
      Row(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              topText,
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
      TextFormField(
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
        ),
      ),
    ]),
  );
}
