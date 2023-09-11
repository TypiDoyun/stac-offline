import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/ownerpages/shopjoin.dart';
import 'package:offline/userpages/usermain.dart';
import 'package:offline/utils/auth/signin.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../Widgets/roundedInputField.dart';
import 'signup.dart';

import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/stat_item.dart';
import 'package:bootpay/model/user.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final signKey = GlobalKey<FormState>();
  final loginInput = {
    "id": "",
    "password": "",
  };

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Background(
      child: Form(
        key: signKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "로그인",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: size.height * 0.02),
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldContainer(
                color: Theme.of(context).colorScheme.onSecondaryContainer,
                hintText: "아이디",
                keyboardType: TextInputType.visiblePassword,
                enabled: true,
                onSaved: (val) {
                  loginInput["id"] = val;
                },
                validator: (val) {
                  return null;
                },
                icon: Icons.person,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFieldContainer(
                  color: Theme.of(context).colorScheme.onSecondaryContainer,
                  hintText: "비밀번호",
                  keyboardType: TextInputType.visiblePassword,
                  enabled: true,
                  obscureText: true,
                  onSaved: (val) {
                    loginInput["password"] = val;
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.lock),
              const SizedBox(
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                height: size.width * 0.14,
                width: size.width,
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
                      signKey.currentState!.save();
                      await signIn(loginInput["id"]!, loginInput["password"]!)
                          ? Get.offAll(const UserMain(), transition: Transition.fade,)
                          : Get.snackbar("다시 한번 확인하세요!", "아이디 혹은 비밀번호가 잘못됬어요.");
                      setState(() {});
                    }
                  },
                  child: Text(
                    "로그인",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.tertiary,
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(
                        const SignUpPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("회원가입하기",
                          style: TextStyle(fontSize: size.height * 0.015)),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.17,
                  ),
                  InkWell(
                    onTap: () {
                      Get.to(
                        const ShopJoinPage(),
                        transition: Transition.rightToLeft,
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Text("매장 등록하기",
                          style: TextStyle(fontSize: size.height * 0.015)),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginInputWidget extends StatelessWidget {
  const LoginInputWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      padding: const EdgeInsets.fromLTRB(20, 5, 20, 15),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(),
    );
  }
}

