import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/Widgets/background.dart';
import 'package:offline/utils/common/get-owner-info.dart';

import '../Widgets/roundedInputField.dart';
import '../userpages/signup.dart';

class ShopJoinPage extends StatefulWidget {
  const ShopJoinPage({Key? key}) : super(key: key);

  @override
  State<ShopJoinPage> createState() => _ShopJoinPageState();
}

class _ShopJoinPageState extends State<ShopJoinPage> {
  final shopJoinformKey = GlobalKey<FormState>();

  final PageController _pageController = PageController(initialPage: 0);

  TextEditingController residentNumber = TextEditingController();
  TextEditingController merchantname = TextEditingController();


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "매장 가입하기",
          style: TextStyle(
            color: Colors.black,
            fontSize: 23,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Form(
        key: shopJoinformKey,
        child: Background(
          child: Container(
            alignment: Alignment.center,
            height: 1000,
            width: 1000,
            child: PageView(
              controller: _pageController,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    roundedInputField(
                        color: Theme.of(context).colorScheme.tertiary,
                        hintText: "' - '는 생략해주세요.",
                        keyboardType: TextInputType.number,
                        enabled: true,
                        obscureText: true,
                        onSaved: (val) {
                          residentNumber = val;
                        },
                        validator: (val) {
                          return null;
                        },
                        icon: Icons.lock),
                    SizedBox(
                      height: size.width * 0.04,
                    ),
                    roundedInputField(
                        color: Theme.of(context).colorScheme.tertiary,
                        hintText: "ex)홍길동",
                        keyboardType: TextInputType.text,
                        enabled: true,
                        obscureText: true,
                        onSaved: (val) {
                        },
                        validator: (val) {
                          return null;
                        },
                        icon: Icons.lock),
                    SizedBox(
                      height: size.width * 0.04,
                    ),
                    roundedInputField(
                        color: Theme.of(context).colorScheme.tertiary,
                        hintText: "ex)00000000",
                        keyboardType: TextInputType.number,
                        enabled: true,
                        obscureText: true,
                        onSaved: (val) {
                        },
                        validator: (val) {
                          return null;
                        },
                        icon: Icons.lock),
                    SizedBox(
                      height: size.width * 0.04,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      height: size.width * 0.15,
                      width: size.width * 0.5,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        onPressed: () async {
                          //사업자 등록 번호 조회 API
                          final isValid = shopJoinformKey.currentState!.validate();
                          if (isValid) {
                            shopJoinformKey.currentState!.save();
                            await getOwnerInfo(
                            );
                          }
                          // checkBusinessRegistration(registration);
                        },
                        child: const Text(
                          "매장 조회하기",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    signInputField(
                      topText: "비밀번호",
                      maxLength: 15,
                      color: Colors.white,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      enabled: true,
                      obscureText: true,
                      validator: (val) {
                        // if (val.isEmpty) {
                        //   return "비밀번호을 입력해주세요.";
                        // }
                        // // 특수 문자나 띄어쓰기가 포함되어 있는지 검증
                        // if (specialCharRegexNum.allMatches(val).length < 3) {
                        //   return "숫자 3자 이상 입력해야 합니다.";
                        // }
                        // RegExp specialCharRegex1 = RegExp(r'[ ]');
                        // if (specialCharRegex1.hasMatch(val)) {
                        //   return "공백은 입력할 수 없습니다.";
                        // }
                        return null; // 유효한 값인 경우 null을 반환
                      },
                      icon: Icons.lock,
                    ),
                    signInputField(
                      topText: "비밀번호 확인",
                      maxLength: 15,
                      color: Colors.white,
                      hintText: "Password",
                      keyboardType: TextInputType.visiblePassword,
                      enabled: true,
                      obscureText: true,
                      validator: (val) {
                        // if (val.isEmpty) {
                        //   return "비밀번호를 재입력해주세요.";
                        // }
                        // if (val != userPasswordCont.text) {
                        //   return "비밀번호를 다시 확인해주세요.";
                        // }
                        return null;
                      },
                      icon: Icons.lock_outline,
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }
}

// class BusinessRegistration {
//   String registrationNumber;
//   String registrationDate;
//   List<String> presidents;
//   String businessName;
//   String corpNumber;
//   String businessSector;
//   String businessType;
//   String businessAddress;
//
//   BusinessRegistration(
//       this.registrationNumber,
//       this.registrationDate,
//       this.presidents,
//       this.businessName,
//       this.corpNumber,
//       this.businessSector,
//       this.businessType,
//       this.businessAddress);
// }
//
// const String businessmanServiceKey =
//     "55vkrgaOLK%2F6YNyRpD4WGnGROVFAepA%2BctN2zrY%2FkZasPPUCIWkIHNgfGKhoWnUic8uzh08ZdfwBFwwY9zz%2FJQ%3D%3D";
// const String businessmanUrl =
//     "https://api.odcloud.kr/api/nts-businessman/v1/validate";
//
// Future<bool> checkBusinessRegistration(
//     BusinessRegistration registration) async {
//   print(registration.presidents);
//   final body = json.encode({
//     "businesses": [
//       {
//         "b_no": "0000000000",
//         "start_dt": "20000101",
//         "p_nm": "홍길동",
//         "p_nm2": "홍길동",
//         "b_nm": "(주)테스트",
//         "corp_no": "0000000000000",
//         "b_sector": "",
//         "b_type": "",
//         "b_adr": ""
//       }
//     ]
//   });
//
//   try {
//     final response = await http.post(
//         Uri.parse("$businessmanUrl?serviceKey=$businessmanServiceKey"),
//         body: body);
//     print(response.body);
//     final data = json.decode(response.body);
//     // print(response[0]["b_no"]);
//     // if (response["status_code"] != "OK") return false;
//     // if (response["data"][0]["valid"] == "02") return false;
//     // print("respons: $response");
//   } catch (error) {
//     print('Error while sending data: $error');
//   }
//
//   return true;
// }
