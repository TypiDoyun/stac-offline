import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/ownerpages/shopjoin.dart';
import 'package:offline/userpages/usermain.dart';
import 'package:offline/utils/auth/signin.dart';
import 'package:http/http.dart' as http;
import 'package:offline/utils/auth/try-refresh-access-token.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/roundedInputField.dart';
import 'signup.dart';

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
    bool signInCheck = true;

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
            const SizedBox(
              height: 20,
            ),
            roundedInputField(
              color: Colors.black12,
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
            roundedInputField(
                color: Colors.black12,
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
              width: size.width * 0.8,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), //볼더 제거
                  ),
                  shadowColor: Colors.white.withOpacity(0),
                ),
                onPressed: () async {
                  final isValid = signKey.currentState!.validate();
                  if (isValid) {
                    signKey.currentState!.save();
                    await signIn(loginInput["id"]!, loginInput["password"]!) ? Get.offAll(UserMain()) : Get.snackbar("다시 한번 확인하세요!","아이디 혹은 비밀번호가 잘못됬어요.");
                    setState(() {
                    });
                  }
                  // getUserFromServer(userToken);
                },
                child: const Text("로그인"),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.to(SignUpPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text("회원가입하기"),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.17,
                ),
                InkWell(
                  onTap: () {
                    Get.to(ShopJoinPage());
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: const Text("매장 등록하기"),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    SharedPreferences prefrs = await SharedPreferences.getInstance();
                    await tryRefreshAccessToken();
                    String? accessToken = prefrs.getString("accessToken");
                    if (accessToken == null) return;
                    try {
                      final response = await http.get(
                        Uri.parse('${dotenv.env["SERVER_URL"]}/user/profile'), // 서버의 엔드포인트 URL로 변경
                        headers: {
                          'Content-Type': 'application/json',
                          'Accept': 'application/json',
                          'Authorization': 'Bearer $accessToken',
                        }
                      );
                      dynamic data = json.decode(response.body);
                      print(data["username"]);
                    } catch (e) {
                      print("error: 토큰 만료됨");
                    }
                  },
                  child: Text("데이터 불러오기"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
