import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/userpages/usermain.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/User.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? test;

  dynamic data;

  User? user;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user = User(
        id: prefs.getString("id"),
        username: prefs.getString("username"),
        password: prefs.getString("password"),
        phoneNumber: prefs.getString("phoneNumber"),
        // Corrected typo
        birthday: prefs.getString("birthday"),
      );
    });
    print('여기: ${user!.username}');
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: size.height * 0.02),
              child: Text(
                "회원 정보",
                style: TextStyle(
                  fontSize: size.height * 0.02,
                  fontWeight: FontWeight.bold,
                  fontFamily: "NotoSansKR",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.width * 0.07),
              child: Text(
                user != null
                    ? "어서오세요 ${user!.username}님. Offline입니다."
                    : "로딩 중...", // Handle user being null during loading
                style: TextStyle(
                    fontSize: size.height * 0.015, fontFamily: "NotoSansKR", fontWeight: FontWeight.bold),
              ),
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: size.height * 0.02),
                alignment: Alignment.centerLeft,
                height: size.height * 0.3,
                width: size.width * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).colorScheme.primaryContainer,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Text(
                            "아이디",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                        Container(
                          child: Text(
                            "성함",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                        Container(
                          child: Text(
                            "생년월일",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                        Container(
                          child: Text(
                            "주소",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          child: Text(
                            user != null ?
                            user!.id! : "로딩중",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                        Container(
                          child: Text(
                            user != null ?
                            user!.username! : "로딩중",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                        Container(
                          child: Text(
                            user != null ?
                            user!.birthday! : "로딩중",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                        Container(
                          child: Text(
                            "",
                            style: TextStyle(fontSize: size.height * 0.016),
                          ),
                        ),
                      ],
                    ),
                  ],
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.dialog(
                      (AlertDialog(
                        title: Text(
                          "정말로 로그아웃 하시겠습니까?",
                        ),
                        actions: [
                          TextButton(
                            child: const Text("아니요"),
                            onPressed: () => Get.back(),
                          ),
                          TextButton(
                              child: const Text("네"),
                              onPressed: () async {
                                SharedPreferences prefrs =
                                    await SharedPreferences.getInstance();
                                prefrs.remove("accessToken");
                                Get.offAll(const UserMain());
                              }),
                        ],
                      )),
                    );
                  },
                  child: Text(
                    "로그아웃",
                    style: TextStyle(fontSize: size.height * 0.015),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      (AlertDialog(
                        title: const Text(
                          "정말로 회원을 탈퇴하시겠습니까?",
                        ),
                        actions: [
                          TextButton(
                              child: const Text("아니요"), onPressed: () async {}),
                          TextButton(
                            child: const Text("네"),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      )),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "회원 탈퇴",
                      style: TextStyle(fontSize: size.height * 0.015),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
