import 'package:flutter/material.dart';

class ClothesUpload extends StatefulWidget {
  const ClothesUpload({super.key});

  @override
  State<StatefulWidget> createState() => ClothesUploadState();
}

class ClothesUploadState extends State<ClothesUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text("옷 전시 준비 중...",
            style: TextStyle(
              color: Colors.black,
              fontSize: 23,
              fontWeight: FontWeight.w700,
            ),
        ),
      ),
      body:ListView(
        children: const[
          Column(
            children: [
              SizedBox(height: 30,),
              ClothesNameInput(),
              SizedBox(height: 20,),
              ClothesTagInput(),
              SizedBox(height: 20,),
              ClothesImagesInput(),
              SizedBox(height: 20,),
              ClothesCommentInput(),
              SizedBox(height: 50,),
            ],
          ),
        ],
      )
    );
  }
}

//옷 이름 박스
class ClothesNameInput extends StatelessWidget {
  const ClothesNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white70,
      height: 140,
      child: const Column(
        children: [
          SizedBox(height: 15,),
          Text("옷 이름",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),),
          SizedBox(height: 5,),
          TextField(
            style: TextStyle(fontSize: 26),
          ),
        ],
      ),
    );
  }
}

//해시태그 박스
class ClothesTagInput extends StatelessWidget {
  const ClothesTagInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white70,
      height: 140,
      child: const Column(
        children: [
          SizedBox(height: 15,),
          Text("해시태그",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),),
          SizedBox(height: 5,),
          TextField(
            style: TextStyle(fontSize: 26),
          ),
        ],
      ),
    );
  }
}

//옷 사진 등록
class ClothesImagesInput extends StatelessWidget {
  const ClothesImagesInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white70,
      height: 140,
      child: const Column(
        children: [
          SizedBox(height: 15,),
          Text("사진 등록",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),),
          SizedBox(height: 5,),
        ],
      ),
    );
  }
}

//옷 사진 등록
class ClothesCommentInput extends StatelessWidget {
  const ClothesCommentInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white70,
      height: 170,
      child: const Column(
        children: [
          SizedBox(height: 15,),
          Text("코멘트",
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),),
          SizedBox(height: 5,),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "옷에 대해 간단하게 소개해주세요!",
                hintStyle: TextStyle(fontSize: 16),
              ),
              style: TextStyle(
                fontSize: 18,
              ),
              minLines: 3,
              maxLines: 5,
            ),
          )
        ],
      ),
    );
  }
}
