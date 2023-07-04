import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UserPage extends StatefulWidget{
  @override
  State<UserPage> createState() => UserPageState();
}
class UserPageState extends State<UserPage> {
  final user_id = TextEditingController();
  final user_password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Column(
              children: [
                SizedBox(height: 50,),
                Text("로그인",
                style: TextStyle(color: Colors.black,fontWeight: FontWeight.w900,fontSize: 30),),
                SizedBox(height: 30,),

                //아이디 입력
                TextField(
                  style: const TextStyle(fontSize: 15),
                  textAlign: TextAlign.start,
                  controller: user_id,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: "전화번호",
                    border: OutlineInputBorder(),
                    hintText: "전화번호를 입력하세요",
                    //errorText: "error text"
                  ),
                ),
                SizedBox(height: 15,),

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
                    print("${user_id.text}\n${user_password.text}");
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    ElevatedButton(onPressed: () {}, child: Text("회원가입")),
                    SizedBox(width: 20,),
                    ElevatedButton(onPressed: () {}, child: Text("매장등록")),
                  ]

                )

            ]),
        ),),
      ),
    );
  }

}