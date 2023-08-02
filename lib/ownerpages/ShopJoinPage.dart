import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:offline/ownerpages/OwnerPage.dart';

import 'ClothesUploadPage.dart';

class ShopJoinPage extends StatefulWidget {
  const ShopJoinPage({Key? key}) : super(key: key);

  @override
  State<ShopJoinPage> createState() => _ShopJoinPageState();
}

class _ShopJoinPageState extends State<ShopJoinPage> {
  final shopJoinformKey = GlobalKey<FormState>();

  final Map shopJoinInfo = {
    "shop_businessRegistrationNumber" : "",
    "shop_name" : "",
    "shop_number" : "",
    "shop_address" : "",
    "onwer_name" : "",
    "owner_residentRegistrationNumber" : "",
  };

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
              renderTextFormField(
                label: '사업자 등록 번호',
                keyboardType: TextInputType.number,
                onSaved: (val) {
                  shopJoinInfo["shop_businessRegistrationNumber"] = val;
                },
                validator: (val) {
                  if (val.length < 1) {
                    return '정보를 입력하세요!';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    //사업자 등록 번호 조회 API
                    final isValid = shopJoinformKey.currentState!.validate();
                    if (isValid) {
                      shopJoinformKey.currentState!.save();
                    }
                    print(shopJoinInfo["shop_businessRegistrationNumber"]);
                  },
                  child: Text("매장 조회하기",
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
