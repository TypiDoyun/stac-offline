import 'package:flutter/material.dart';
import 'package:flutter_naver_map/flutter_naver_map.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../classes/clothes.dart';

import 'package:bootpay/bootpay.dart';
import 'package:bootpay/model/extra.dart';
import 'package:bootpay/model/item.dart';
import 'package:bootpay/model/payload.dart';
import 'package:bootpay/model/stat_item.dart';
import 'package:bootpay/model/user.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class UserSelectedClothesPage extends StatefulWidget {
  const UserSelectedClothesPage({Key? key, required this.clothesInfo})
      : super(key: key);
  final Clothes clothesInfo;

  @override
  State<UserSelectedClothesPage> createState() =>
      _UserSelectedClothesPageState(clothesInfo);
}

class _UserSelectedClothesPageState extends State<UserSelectedClothesPage> {
  final PageController _pageController = PageController();

  final image = [
    'assets/images/clothesImage1.jpeg',
    'assets/images/clothesImage2.jpeg',
    'assets/images/clothesImage3.jpeg'
  ];

  _UserSelectedClothesPageState(this.clothesInfo);

  final Clothes clothesInfo;

  var f = NumberFormat('###,###,###,###,###,###');

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.white.withOpacity(0),
      ),
      body: Column(
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
                        itemCount: clothesInfo.images.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                              // Make the height same as width for a square
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image:
                                      NetworkImage(clothesInfo.images[index]),
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
                    padding: EdgeInsets.symmetric(vertical: size.height * 0.02),
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
                                image:
                                    NetworkImage(clothesInfo.owner.shop.logo),
                                fit: BoxFit.cover, // 이미지가 잘리지 않도록 설정
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.04,
                          ),
                          SizedBox(
                            width: size.width * 0.52,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  clothesInfo.owner.shop.name,
                                  style: const TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Text(
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
                                style:
                                    TextStyle(fontSize: 11, color: Colors.grey),
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 24, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          child: Text(
                            clothesInfo.name,
                            style: const TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.w400,
                              height: 1.5,
                              letterSpacing: -0.3,
                            ),
                            maxLines: 3,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Text(
                                  clothesInfo.discountRate == 0
                                      ? ''
                                      : '${clothesInfo.discountRate}%',
                                  style: TextStyle(
                                    color: clothesInfo.discountRate == 0
                                        ? Colors.black
                                        : Colors.red,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.8,
                                  ),
                                ),
                                SizedBox(
                                  width: clothesInfo.discountRate == 0 ? 0 : 3,
                                ),
                                Text(
                                  clothesInfo.discountRate == 0
                                      ? '${f.format(clothesInfo.price)}원'
                                      : '${f.format((clothesInfo.price - (clothesInfo.price * clothesInfo.discountRate / 100)))}',
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -0.7,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              clothesInfo.discountRate == 0
                                  ? ""
                                  : "${f.format(clothesInfo.price)}원",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 5),
                          child: const Divider(
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(
                          height: size.height * 0.03,
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
                                clothesInfo.size.join(", "),
                                style: TextStyle(
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
                          padding: const EdgeInsets.all(20),
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
                          child: Text(
                            "${clothesInfo.comment}",
                            style: TextStyle(fontWeight: FontWeight.w400),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.all(20),
                          child: const Text(
                            "위치",
                            style: TextStyle(
                              fontSize: 19,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          height: size.height * 0.3,
                          child: const NaverMap(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: Container(
              margin: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              height: size.height * 0.1,
              width: size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 8,
                  ),
                ],
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      flex: 1,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.black38.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                ),
                              ]),
                          child: const Center(
                            child: Icon(
                              Icons.phone,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.02,
                    ),
                    Expanded(
                      flex: 3,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 15,
                                ),
                              ]),
                          child: const Center(
                            child: Text(
                              "결제하기",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    final Future<WebViewController> _webViewControllerFuture;

    // _webViewControllerFuture.then((value) => value.runJavascript(javaScriptString))

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 50.0),
            child: Column(
              children: [
                TextButton(
                    onPressed: () => Get.to(DefaultPayment()),
                    child: const Text('1. PG일반 결제 테스트', style: TextStyle(fontSize: 16.0))
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DefaultPayment extends StatelessWidget {
  // You can ask Get to find a Controller that is being used by another page and redirect you to it.

  String webApplicationId = '5b8f6a4d396fa665fdc2b5e7';
  String androidApplicationId = '5b8f6a4d396fa665fdc2b5e8';
  // String iosApplicationId = '62c3f02be38c3000215af228';
  String iosApplicationId = '5b8f6a4d396fa665fdc2b5e9';

  // String iosApplicationId = '60949a355b2948002e07c707';




  @override
  Widget build(context) {
    // Access the updated count variable
    return Scaffold(
        body: SafeArea(
            child: Center(
                child: TextButton(
                    onPressed: () => bootpayTest(context),
                    child: const Text('PG일반 결제 테스트', style: TextStyle(fontSize: 16.0))
                )
            )
        )
    );
  }

  void bootpayTest(BuildContext context) {
    Payload payload = getPayload();
    if(kIsWeb) {
      payload.extra?.openType = "iframe";
    }


    Bootpay().requestPayment(
      context: context,
      payload: payload,
      showCloseButton: false,
      // closeButton: Icon(Icons.close, size: 35.0, color: Colors.black54),
      onCancel: (String data) {
        print('------- onCancel: $data');
      },
      onError: (String data) {
        print('------- onCancel: $data');
      },
      onClose: () {
        print('------- onClose');
        // Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출
        closeBootpay(context);
        //TODO - 원하시는 라우터로 페이지 이동
      },
      onIssued: (String data) {
        print('------- onIssued: $data');
      },
      onConfirm: (String data) {
        /**
            1. 바로 승인하고자 할 때
            return true;
         **/
        /***
            2. 클라이언트 승인 하고자 할 때
            Bootpay().transactionConfirm();
            return false;
         ***/
        /***
            3. 서버승인을 하고자 하실 때 (클라이언트 승인 X)
            return false; 후에 서버에서 결제승인 수행
         */
        Bootpay().transactionConfirm();
        return false;
      },
      onDone: (String data) {
        print('------- onDone: $data');
      },
    );
  }

  Payload getPayload() {
    Payload payload = Payload();
    Item item1 = Item();
    item1.name = "찌개+계란찜 set"; // 주문정보에 담길 상품명
    item1.qty = 1; // 해당 상품의 주문 수량
    item1.id = "10539"; // 해당 상품의 고유 키
    item1.price = 1000; // 상품의 가격

    // Item item2 = Item();
    // item2.name = "키보드"; // 주문정보에 담길 상품명
    // item2.qty = 1; // 해당 상품의 주문 수량
    // item2.id = "ITEM_CODE_KEYBOARD"; // 해당 상품의 고유 키
    // item2.price = 25000; // 상품의 가격
    // List<Item> itemList = [item1, item2];
    List<Item> itemList = [item1];

    payload.webApplicationId = webApplicationId; // web application id
    payload.androidApplicationId = androidApplicationId; // android application id
    payload.iosApplicationId = iosApplicationId; // ios application id


    // payload.methods = ['card', 'phone', 'vbank', 'bank', 'kakao'];
    payload.pg = "페이앱";
    payload.method = "카드";
    payload.orderName = "찌개+계란찜 set"; //결제할 상품명
    payload.price = 1000.0; //정기결제시 0 혹은 주석
    payload.orderId = "0e137003-dc03-4380-9320-578eaaed2423";



    payload.orderId = DateTime.now().millisecondsSinceEpoch.toString(); //주문번호, 개발사에서 고유값으로 지정해야함


    payload.metadata = {
      "callbackParam1" : "value12",
      "callbackParam2" : "value34",
      "callbackParam3" : "value56",
      "callbackParam4" : "value78",
    }; // 전달할 파라미터, 결제 후 되돌려 주는 값
    payload.items = itemList; // 상품정보 배열

    User user = User(); // 구매자 정보
    user.id = "275";
    user.username = "부트페이테스트";
    user.email = "user1234@gmail.com";
    user.area = "서울";
    user.phone = "01040334678";
    user.addr = '서울시 동작구 상도로 222';

    Extra extra = Extra(); // 결제 옵션
    extra.appScheme = 'ggoggama';
    extra.cardQuota = '3';
    // extra.openType = 'popup';

    // extra.carrier = "SKT,KT,LGT"; //본인인증 시 고정할 통신사명
    // extra.ageLimit = 20; // 본인인증시 제한할 최소 나이 ex) 20 -> 20살 이상만 인증이 가능

    payload.user = user;
    payload.extra = extra;
    return payload;
  }

  Future<void> closeBootpay(BuildContext context) async {

    await Future.delayed(Duration(seconds: 0)).then((value) {
      print('Bootpay().dismiss');

      Bootpay().dismiss(context); //명시적으로 부트페이 뷰 종료 호출

      // Navigator.pop(context);

      // Navigator.pop(context);

    });

  }
}

@Deprecated('예제를 위해 제공되는 클래스입니다. 이 작업은 서버사이드에서 수행되어야 합니다.')
class ApiProvider extends GetConnect {
  String get defaultUrl {
    return 'https://api.bootpay.co.kr';
  }


  Future<Response> getRestToken(String applicationId, String privateKey) async {
    var payload = {
      'application_id': applicationId,
      'private_key': privateKey
    };

    String url = "$defaultUrl/v2/request/token";

    return post(
        url,
        payload,
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json'
        }
    );
  }

  Future<Response> getEasyPayUserToken(String token, User user) async {
    var payload = {
      'user_id': user.id,
      'email': user.email,
      'name': user.username,
      'gender': user.gender,
      'birth': user.birth,
      'phone': user.phone,
    };

    String url = "$defaultUrl/v2/request/user/token";

    return post(
        url,
        payload,
        contentType: 'application/json',
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        }
    );
  }
}

// class Indicator extends StatelessWidget {
//   final bool isActive;
//
//   const Indicator({super.key, required this.isActive});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.all(4),
//       width: 10,
//       height: 10,
//       decoration: BoxDecoration(
//         box
//          BoxShadow(
//           color: Colors.grey.withOpacity(0.2),
//           spreadRadius: 1,
//           blurRadius: 15,
//         ),
//         color: isActive ? Colors.white.withOpacity(0.8) : Colors.grey,
//       ),
//     );
//   }
// }
