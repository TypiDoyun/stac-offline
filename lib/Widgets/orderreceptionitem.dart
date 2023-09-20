import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderReceptionItem extends StatelessWidget {
  final String clothesLocation, username, address;
  final int price;
  final void Function() onTap;

  const OrderReceptionItem(
      {Key? key,
      required this.clothesLocation,
      required this.username,
      required this.address,
      required this.price,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: size.width * 0.01),
        height: size.height * 0.15,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: size.width * 0.3,
              width: size.width * 0.3,
              color: Colors.black,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '옷 이름',
                  style: TextStyle(
                    fontSize: size.height * 0.02,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: size.height * 0.07,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '20,000',
                        style: TextStyle(
                          fontSize: size.height * 0.015,
                        ),
                      ),
                      Text(
                        'Size: Free',
                        style: TextStyle(
                          fontSize: size.height * 0.015,
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.5,
                        child: Text(
                          'isThreeLine : true 로 주면 subtitle 이 어떻게 변할까',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: size.height * 0.013,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      (AlertDialog(
                        title: const Text("정말로 전시를 중지하실껀가요?"),
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
                  icon: const Icon(Icons.delete),
                ),
                IconButton(
                  onPressed: () {
                    Get.dialog(
                      (AlertDialog(
                        title: const Text("정말로 전시를 중지하실껀가요?"),
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
                  icon: const Icon(Icons.delete),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.onSecondaryContainer,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      "픽업 완료",
                      style: TextStyle(fontSize: size.height * 0.015),
                    ),
                  ),
                ),
              ],
            )
          ],
        ), //dense: true,
      ),
    );
  }
}
