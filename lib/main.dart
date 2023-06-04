
import 'package:flutter/material.dart';
import 'package:offline/Widgets/Shop_Listitem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => MyTest();
}

class MyTest extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: searchPageHeader(),
        body: Column(
          children: [
            const SizedBox(height: 25,),
            SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    const SizedBox(width: 20),
                    ShopListItem(),
                    ShopListItem(),
                    ShopListItem(),
                    ShopListItem(),
                    ShopListItem(),
                    ShopListItem(),
                  ],
                ),
              ),
            const Padding(padding: EdgeInsets.symmetric(horizontal: 24),

            )
          ]
        ),
        bottomNavigationBar: const BottomAppBar(
          color: Colors.grey,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
              IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
              IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
              IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
              IconButton(onPressed: null, icon: Icon(Icons.coffee,color: Colors.black,)),
            ],
          ),
        ),
          ),
        );
  }

  //검색창 입력내용 controller
  TextEditingController seatrchTextEditingController = TextEditingController();
  //아이콘 X클릭시 검색어 삭제
  emptyTheTextFormField() {
    seatrchTextEditingController.clear();
  }

  AppBar searchPageHeader() {
    return AppBar(
      backgroundColor: Colors.black,
      title: TextFormField(
        controller: seatrchTextEditingController,
        decoration: InputDecoration(
          hintText: "검색어를 입력하세요!",
          hintStyle: const TextStyle(
            color: Colors.grey
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey,)
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white,)
          ),
          filled: true,
          prefixIcon: const Icon(Icons.person_pin, color: Colors.white, size: 30,),
          suffixIcon: IconButton(icon: const Icon(Icons.clear,color: Colors.white,),
            onPressed: emptyTheTextFormField)
            ),
        style: const TextStyle(
          fontSize: 18,
          color: Colors.white
        ),
        )
      );
  }
}