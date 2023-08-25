
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

  @override
  initState() {
    super.initState();
    (() async {
      SharedPreferences prefrs = await SharedPreferences.getInstance();
      User user = User(
        id: prefrs.getString("id"),
        username: prefrs.getString("username"),
        password: prefrs.getString("password"),
        phoneNumber: prefrs.getString("phoneNumer"),
        birthday: prefrs.getString("birthday"),
      );
      print(user);
    }());
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: Background(
        child: Column(
          children: [
            const Text(
              "회원 정보",
              style: TextStyle(fontSize: 25),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: size.width * 0.1),
              child: const Text(
                "어서오세요 님. Offline입니다.",
                style: TextStyle(fontSize: 20),
              ),
            ),
            Card(
              child: Container(
                alignment: Alignment.topCenter,
                height: size.width * 0.24,
                child: SizedBox(
                  child: Row(
                    children: [
                      SizedBox(
                        width: size.width * 0.25,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "ㅎㅇ",
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            height: size.width * 0.02,
                          ),
                          const Text(
                            "ㅎㅇ",
                            style: TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.dialog(
                      (AlertDialog(
                        title: const Text("정말로 로그아웃 하시겠습니까?"),
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
                  child: const Text("로그아웃"),
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      (AlertDialog(
                        title: const Text("정말로 회원을 탈퇴하시겠습니까?"),
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
                    child: const Text("회원 탈퇴"),
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
