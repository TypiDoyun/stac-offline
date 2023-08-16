
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Widgets/roundedInputField.dart';

class SignPage extends StatelessWidget {
  SignPage({Key? key}) : super(key: key);

  final Map userInfoInput = {
    "userName": "",
    "userId": "",
    "userPassword": "",
    "userPhonenumber": 0,
    "userBirth": 0,
    "userLocation": "",
  };

  final signKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
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
                  roundedInputField(
                    color: Colors.black12,
                    hintText: "성함",
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSaved: (val) {
                      userInfoInput["userName"] = val;
                    },
                    validator: (val) {
                      return null;
                    },
                    icon: Icons.person_outline
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  roundedInputField(
                    color: Colors.black12,
                    hintText: "아이디",
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSaved: (val) {
                      userInfoInput["userId"] = val;
                    },
                    validator: (val) {
                      return null;
                    },
                    icon: Icons.person
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  roundedInputField(
                    color: Colors.black12,
                    hintText: "비밀번호",
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSaved: (val) {
                      userInfoInput["userPassword"] = val;
                    },
                    validator: (val) {
                      return null;
                    },
                    icon: Icons.lock
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  roundedInputField(
                    color: Colors.black12,
                    hintText: "전화번호",
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSaved: (val) {
                      userInfoInput["userPhonenumber"] = val;
                    },
                    validator: (val) {
                      return null;
                    },
                    icon: Icons.phone
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  roundedInputField(
                    color: Colors.black12,

                    hintText: "생년월일",
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSaved: (val) {
                      userInfoInput["userBirth"] = val;
                    },
                    validator: (val) {
                      return null;
                    },
                    icon: Icons.cake),
                  const SizedBox(
                    height: 10,
                  ),
                  roundedInputField(
                    color: Colors.black12,
                    hintText: "주소",
                    keyboardType: TextInputType.text,
                    enabled: true,
                    onSaved: (val) {
                      userInfoInput["userLocation"] = val;
                    },
                    validator: (val) {
                      return null;
                    },
                    icon: Icons.location_on),
                  ElevatedButton(
                    onPressed: () {
                      final isValid = signKey.currentState!.validate();
                      if (isValid) {
                        signKey.currentState!.save();
                        Get.back();
                      }
                      print(userInfoInput);
                    },
                    child: const Text("회원가입 하기")
                  ),
                ],
              ),
            ),
          )
        ),
      ),
    );
  }
}
