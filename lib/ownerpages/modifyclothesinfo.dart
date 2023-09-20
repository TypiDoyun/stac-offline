import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


final imagesList = [
  'assets/images/clothesImage1.jpeg',
  'assets/images/clothesImage2.jpeg',
  'assets/images/clothesImage3.jpeg',
];

final Map clothesInfo = {
  "name": "ㅎㅇ",
  "discountRate": 20,
  "price": 20000,
  "size": ["Free"],
  "comment": "이쁜 옷임 ㅇㅇ",
};

class ModityClothesInfo extends StatefulWidget {
  const ModityClothesInfo({Key? key}) : super(key: key);

  @override
  State<ModityClothesInfo> createState() => _ModityClothesInfoState();
}

class _ModityClothesInfoState extends State<ModityClothesInfo> {
  var f = NumberFormat('###,###,###,###,###,###');

  final modifyKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: Form(
        key: modifyKey,
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: 1,
                      child: ClipRRect(
                        child: PageView.builder(
                          itemCount: imagesList.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Center(
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.width,
                                // Make the height same as width for a square
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage(imagesList[index]),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(
                          horizontal: size.width * 0.03,
                          vertical: size.height * 0.01),
                      padding:
                          EdgeInsets.symmetric(vertical: size.height * 0.02),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 1,
                            blurRadius: 15,
                          ),
                        ],
                      ),
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: size.width * 0.11,
                              width: size.width * 0.11,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                image: DecorationImage(
                                  image: AssetImage(imagesList[1]),
                                  fit: BoxFit.cover, // 이미지가 잘리지 않도록 설정
                                ),
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.04,
                            ),
                            SizedBox(
                              width: size.width * 0.52,
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "가게 이름",
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "용인시 처인구 김량장동 어쩌구 301-112312",
                                    style: TextStyle(
                                        fontSize: 12, color: Colors.grey),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: size.width * 0.03,
                            ),
                            const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "현 위치로부터",
                                  style: TextStyle(
                                      fontSize: 11, color: Colors.grey),
                                ),
                                Text(
                                  "2.1km",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue),
                                ),
                              ],
                            ),
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: size.height * 0.01),
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSecondaryContainer,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "옷 이름 수정",
                                  style:
                                      TextStyle(fontSize: size.height * 0.015),
                                ),
                                TextFormField(
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    letterSpacing: -0.3,
                                  ),
                                  maxLines: 3,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "옷 이름",
                                    icon: Icon(Icons.mode),
                                  ),
                                  initialValue: clothesInfo["name"],
                                  onChanged: (val) {
                                    clothesInfo["name"] = val;
                                  },
                                  validator: (value) {
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.03,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "가격  - ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.02,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.7,
                                child: TextFormField(
                                  style: TextStyle(
                                    fontSize: size.height * 0.025,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  keyboardType: TextInputType.number,
                                  validator: (val) {
                                    val! as int == 0 ? "가격을 다시 확인해주세요" : null;
                                    return null;
                                  }
                                  ,
                                  initialValue: clothesInfo["price"].toString(),
                                  onChanged: (val) {
                                    setState(() {
                                      num parsedValue =
                                          double.tryParse(val) ?? 0;
                                      clothesInfo["price"] = parsedValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    icon: Icon(
                                      Icons.mode_edit,
                                      size: size.height * 0.03,
                                    ),
                                    hintText: "가격 수정",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: size.height * 0.015,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                margin: const EdgeInsets.symmetric(vertical: 15),
                                child: Text(
                                  "세일  - ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: size.height * 0.02,
                                    color: Colors.red,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: size.width * 0.6,
                                child: TextFormField(
                                  initialValue:
                                      clothesInfo["discountRate"].toString(),
                                  keyboardType: TextInputType.number,
                                  maxLength: 2,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: size.height * 0.02,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  validator: (val) {
                                    if (val?.length == 2) {
                                      return "99% 이상 세일할 순 없어요";
                                    }
                                    return null; // 유효한 값인 경우 null 반환
                                  },
                                  onChanged: (val) {
                                    setState(() {
                                      num discountValue =
                                          double.tryParse(val) ??
                                              0; // 문자열을 숫자로 변환 (기본값은 0)
                                      clothesInfo["discountRate"] =
                                          discountValue;
                                    });
                                  },
                                  decoration: InputDecoration(
                                    counterText: "",
                                    icon: const Icon(
                                      Icons.mode_edit,
                                      color: Colors.red,
                                    ),
                                    hintText: "세일가 수정",
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                      fontSize: size.height * 0.017,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: clothesInfo["discountRate"] == 0 ? 0 : 3,
                              ),
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 5),
                            child: const Divider(
                              color: Colors.black,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '원가 : ${f.format(clothesInfo["price"])}\n세일가 : ${f.format((clothesInfo["price"] - clothesInfo["discountRate"] * (clothesInfo["price"]! / 100)))}',
                                // 저장된 가격 출력, 없을 경우 빈 문자열 출력
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            margin: const EdgeInsets.all(13),
                            child: const Text(
                              "Size",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 13),
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  clothesInfo["size"].join(", "),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.07,
                          ),
                          Container(
                            margin: const EdgeInsets.all(15),
                            child: const Text(
                              "코멘트",
                              style: TextStyle(
                                fontSize: 19,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            height: size.height * 0.2,
                            width: size.width,
                            margin: EdgeInsets.only(bottom: size.height * 0.05),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                ),
                              ],
                            ),
                            child: TextFormField(
                              style: TextStyle(
                                fontSize: size.height * 0.018,
                                fontWeight: FontWeight.w500,
                                height: 2,
                              ),
                              keyboardType: TextInputType.number,
                              validator: (val) {
                                return null;
                              },
                              initialValue: clothesInfo["comment"],
                              maxLines: 6,
                              onChanged: (val) {
                              },
                              decoration: InputDecoration(
                                icon: Icon(
                                  Icons.mode_edit,
                                  size: size.height * 0.03,
                                ),
                                hintText: "가격 수정",
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: size.height * 0.015,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 60,),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModifyClothesTextFiled extends StatelessWidget {
  final Color? color;
  final bool obscureText;
  final String hintText;
  final FormFieldValidator validator;
  final IconData icon;
  final bool? enabled;
  final FormFieldSetter? onSaved;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final String? initialValue;

  const ModifyClothesTextFiled({
    Key? key,
    required this.hintText,
    required this.validator,
    required this.icon,
    this.color,
    this.enabled,
    this.onSaved,
    this.keyboardType,
    this.controller,
    this.onChanged,
    this.obscureText = false,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.05, vertical: size.height * 0.003),
      width: size.width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(29),
      ),
      child: TextFormField(
        initialValue: initialValue,
        controller: controller,
        onChanged: onChanged,
        onSaved: onSaved,
        validator: validator,
        autovalidateMode: AutovalidateMode.always,
        keyboardType: keyboardType,
        enabled: enabled,
        obscureText: obscureText,
        decoration: InputDecoration(
          icon: Icon(icon),
          hintText: hintText,
          border: InputBorder.none,
          hintStyle: TextStyle(
            fontSize: size.height * 0.015,
          ),
        ),
      ),
    );
  }
}
