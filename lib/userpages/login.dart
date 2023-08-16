import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/ownerpages/shopjoin.dart';

import '../Widgets/roundedInputField.dart';
import 'signin.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final signKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Background(
      child: Form(
        key: signKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "로그인",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20,),
            roundedInputField(
              color: Colors.black12,
              hintText: "아이디",
              keyboardType: TextInputType.text,
              enabled: true,
              onSaved: (val) {},
              validator: (val) {
                return null;
              },
              icon: Icons.person,
            ),
            roundedInputField(
              color: Colors.black12,
              hintText: "비밀번호",
              keyboardType: TextInputType.text,
              enabled: true,
              onSaved: (val) {},
              validator: (val) {
                return null;
              },
              icon: Icons.lock
            ),
            const SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: (){
                    Get.to(SignPage());
                  },
                  child: Container(
                    child: const Text("회원가입"),
                  ),
                ),
                InkWell(
                  onTap: (){
                    Get.to(() => ShopJoinPage());
                  },
                  child: Container(
                    child: const Text("매장 등록"),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

