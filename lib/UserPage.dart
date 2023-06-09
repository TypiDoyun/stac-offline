import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:offline/ShopJoin.dart';
import 'package:offline/SignPage.dart';

class UserPage extends StatefulWidget{
  const UserPage({super.key});

  @override
  State<UserPage> createState() => UserPageState();
}
class UserPageState extends State<UserPage> {
  final TextEditingController user_number = TextEditingController();
  final TextEditingController user_password = TextEditingController();

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
                TextField(
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                  controller: user_number,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "전화번호",
                    border: OutlineInputBorder(),
                    hintText: "전화번호를 입력하세요",
                    //errorText: "error text"
                  ),
                ),
                const SizedBox(height: 15,), //공백
                //비밀번호 입력
                TextField(
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                  controller: user_password,
                  obscureText: true,
                  decoration: const InputDecoration(
                    labelText: "비밀번호",
                    border: OutlineInputBorder(),
                    hintText: "비밀번호를 입력하세요",
                  ),
                ),
                ElevatedButton(
                  child: const Text("로그인"),
                  onPressed: () {
                    print("${user_number.text}\n${user_password.text}");
                    sendRequest();
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(onPressed: () {}, child: const Text("회원가입")),
                    const SizedBox(width: 20,),
                    ElevatedButton(onPressed: () {
                      Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const ShopJoinPage()),
                      );
                    }, child: const Text("매장등록")),
                  ]

                )

            ]),
        ),),
      ),
    );
  }
  void sendRequest() async {
    String usernumber = user_number.text;
    String password = user_password.text;

    var url = Uri.parse('http://192.168.2.139:3000/login');
    var response = await http.put(url,body: {'id': usernumber, 'password': password});

    if (response.statusCode == 200) {
      print('Request sent successfully');
      print(response.body);
    } else {
      print('Request failed with status: ${response.statusCode}');
    }
  }
}