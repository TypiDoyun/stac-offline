import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignPage extends StatelessWidget {
  const SignPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Center(
            child:
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("회원가입",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 30,),
                  TextField(),
                  SizedBox(height: 30,),
                  TextField(),
                  SizedBox(height: 30,),
                  TextField(),

                ],
              )
          ),
        ),
      ),
    );
  }
}
