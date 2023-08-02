import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/ShopJoinPage.dart';
import 'package:offline/Widgets/TextInput.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {

  final TextEditingController userId = TextEditingController();
  final TextEditingController userPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 24,horizontal: 40),
        child: Center(
          child: Column(
              children: [
                const SizedBox(height: 50,),
                const Text("로그인",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 30),),
                const SizedBox(height: 30,),
                //아이디 입력
                TextInput(controller: userId, hintText: "아이디", obscureText: false,),
                const SizedBox(height: 15,),

                //비밀번호 입력
                TextInput(controller: userPassword, hintText: "비밀번호", obscureText: true),

                ElevatedButton(
                  child: const Text("로그인"),
                  onPressed: () {
                    print("${userId.text}\n${userPassword.text}");
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("회원가입")),
                    const SizedBox(width: 20,),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => ShopJoinPage());
                      },
                      child: const Text("매장등록"),
                    ),
                  ]
                )
            ]),
        ),),
      ),
    );
  }

  //서버 코드(였던 것)
  // void sendRequest() async {
  //   String user_id = userId.text;
  //   String user_password = userPassword.text;
  //
  //   var url = Uri.parse('http://192.168.2.139:3000/login');
  //   var response = await http.put(url,body: {'id': user_id, 'password': user_password});
  //
  //   if (response.statusCode == 200) {
  //     print('Request sent successfully');
  //     print(response.body);
  //   } else {
  //     print('Request failed with status: ${response.statusCode}');
  //   }
  // }
}