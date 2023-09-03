import 'package:flutter/material.dart';



class OrderReceptionItem extends StatelessWidget {
  final String clothesLocation, username, address;
  final int price;

  const OrderReceptionItem({Key? key, required this.clothesLocation, required this.username, required this.address, required this.price}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              color: Colors.black,
              height: 120,
              width: 120,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    clothesLocation,
                    style: TextStyle(fontSize: 13),
                  ),
                  const SizedBox(
                    height: 13,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "유저 정보",
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        username,
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        address,
                        style: TextStyle(fontSize: 10),
                      ),
                      Text(
                        price.toString(),
                        style: TextStyle(fontSize: 10),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              height: 100,
              padding: EdgeInsets.only(top: 5,bottom: 5,right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Icon(
                      Icons.message,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Icon(Icons.call),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Text(
                        "픽업 완료",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
