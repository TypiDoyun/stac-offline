import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/ownerhome.dart';
import 'package:http/http.dart' as http;

import '../Widgets/roundedInputField.dart';




class ShopJoinPage extends StatefulWidget {
  ShopJoinPage({Key? key}) : super(key: key);

  @override
  State<ShopJoinPage> createState() => _ShopJoinPageState();
}

class _ShopJoinPageState extends State<ShopJoinPage> {
  final shopJoinformKey = GlobalKey<FormState>();

  final BusinessRegistration registration = BusinessRegistration("0000000000", "20000101", ["홍길동", "홍길동전"], "(주)테스트", "0000000000000","","","");
  @override
  Widget build(BuildContext context) {
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
        child: Form(
          key: shopJoinformKey,
          child: ListView(
            children: [
              roundedInputField(
                  color: Colors.black12,
                  hintText: "사업자 등록 번호 입력",
                  keyboardType: TextInputType.number,
                  enabled: true,
                  obscureText: true,
                  onSaved: (val) {
                  },
                  validator: (val) {
                    return null;
                  },
                  icon: Icons.lock
              ),
              ElevatedButton(
                  onPressed: () {
                    //사업자 등록 번호 조회 API
                    final isValid = shopJoinformKey.currentState!.validate();
                    if (isValid) {
                      shopJoinformKey.currentState!.save();
                    }
                    checkBusinessRegistration(registration);
                  },
                  child: const Text("매장 조회하기",
                    style: TextStyle(
                    ),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
          child: SizedBox(
        height: 60,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero, //볼더 제거
            ),
          ),
          onPressed: () {
            Get.to(() => const OwnerPage());
            // Get.offall(() => const OwnerPage());
          },
          child: const Text(
            "매장 가입하기.",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      )),
    );
  }
}

class BusinessRegistration {
  String registrationNumber;
  String registrationDate;
  List<String> presidents;
  String businessName;
  String corpNumber;
  String businessSector;
  String businessType;
  String businessAddress;

  BusinessRegistration(
      this.registrationNumber,
      this.registrationDate,
      this.presidents,
      this.businessName,
      this.corpNumber,
      this.businessSector,
      this.businessType,
      this.businessAddress);
}

const String businessmanServiceKey =
    "55vkrgaOLK%2F6YNyRpD4WGnGROVFAepA%2BctN2zrY%2FkZasPPUCIWkIHNgfGKhoWnUic8uzh08ZdfwBFwwY9zz%2FJQ%3D%3D";
const String businessmanUrl =
    "https://api.odcloud.kr/api/nts-businessman/v1/validate";

Future<bool> checkBusinessRegistration(
    BusinessRegistration registration) async {
  print(registration.presidents);
  final body = json.encode({
    "businesses": [
      {
        "b_no": "0000000000",
        "start_dt": "20000101",
        "p_nm": "홍길동",
        "p_nm2": "홍길동",
        "b_nm": "(주)테스트",
        "corp_no": "0000000000000",
        "b_sector": "",
        "b_type": "",
        "b_adr": ""
      }
    ]
  });

  try {
    final response = await http.post(
        Uri.parse("$businessmanUrl?serviceKey=$businessmanServiceKey"),
        body: body);
    print(response.body);
    final data = json.decode(response.body);
    // print(response[0]["b_no"]);
    // if (response["status_code"] != "OK") return false;
    // if (response["data"][0]["valid"] == "02") return false;
    // print("respons: $response");
  } catch (error) {
    print('Error while sending data: $error');
  }

  return true;
}