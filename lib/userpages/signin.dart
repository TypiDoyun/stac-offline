import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../Widgets/roundedInputField.dart';
import '../servercontroller.dart';

class SignPage extends StatelessWidget {
  SignPage({Key? key}) : super(key: key);

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
                  topText: "성함",
                  color: Colors.white,
                  hintText: "ex) 홍길동",
                  keyboardType: TextInputType.text,
                  enabled: true,
                  onSaved: (val) {
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
                  topText: "아이디",
                  color: Colors.white,
                  hintText: "ID",
                  keyboardType: TextInputType.visiblePassword,
                  enabled: true,
                  onSaved: (val) {
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

                    return null; // 유효한 값인 경우 null을 반환
                  },
                  icon: Icons.person,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero, //볼더 제거
                      ),
                      shadowColor: Colors.white.withOpacity(0),
                    ),
                    onPressed: () {

                    },
                    child: Text(
                      "중복 확인",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ),
                SizedBox(height: 30,),
                signInputField(
                  topText: "비밀번호",
                  color: Colors.white,
                  hintText: "Password",
                  keyboardType: TextInputType.visiblePassword,
                  enabled: true,
                  onSaved: (val) {
                    userInfoInput["userPassword"] = val;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "비밀번호을 입력해주세요.";
                    }

                    // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                    RegExp specialCharRegex =
                        RegExp(r'[!@#\$%^&*(),.?":{}|<>]');
                    if (specialCharRegex.hasMatch(val)) {
                      return "특수 문자는 입력할 수 없습니다.";
                    }

                    return null; // 유효한 값인 경우 null을 반환
                  },
                  icon: Icons.lock,
                ),
                const SizedBox(
                  height: 10,
                ),
                signInputField(
                  topText: "전화번호",
                  color: Colors.white,
                  hintText: "ex) 01012345678",
                  keyboardType: TextInputType.number,
                  enabled: true,
                  onSaved: (val) {
                    userInfoInput["userPhonenumber"] = val;
                  },
                  validator: (val) {
                    if (val.isEmpty) {
                      return "성함을 입력해주세요.";
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
                  onSaved: (val) {
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
                      signKey.currentState!.save();
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
  required FormFieldSetter onSaved,
  required FormFieldValidator validator,
  required IconData icon,
  required bool enabled,
  required Color color,
  required String topText,
  TextEditingController? controller,
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
        controller: controller,
        onSaved: onSaved,
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
