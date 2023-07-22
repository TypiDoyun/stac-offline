import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ClothesUpload extends StatefulWidget {
  const ClothesUpload({super.key});

  @override
  State<StatefulWidget> createState() => ClothesUploadState();
}

class ClothesUploadState extends State<ClothesUpload> {
  final TextEditingController clothes_name = TextEditingController();
  late String clothesName;



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
        children: [
          Column(
            children: [
              const SizedBox(height: 30,),
              ClothesNameInput(clothesNameController: clothes_name),
              const SizedBox(height: 20,),
              const ClothesTagInput(),
              const SizedBox(height: 20,),
              ClothesImagesInput(),
              const SizedBox(height: 20,),
              const ClothesCommentInput(),
              const SizedBox(height: 50,),
            ],
          ),
        ],
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
              print(clothes_name.text);
              Navigator.pop(context);
            },
            child: const Text(
              "옷 전시하기!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700,),
            ),
          ),
        )
      ),
    );
  }
}

//옷 이름 박스
class ClothesNameInput extends StatelessWidget {
  final TextEditingController clothesNameController;

  const ClothesNameInput({super.key, required this.clothesNameController});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white70,
      height: 140,
      child: Column(
        children: [
          const SizedBox(height: 15,),
          const Text("옷 이름",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),),
          const SizedBox(height: 5,),
          TextField(
            controller: clothesNameController,
            style: const TextStyle(fontSize: 26),
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
              fontSize: 22,
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

//옷 사진 등록 박스
class ClothesImagesInput extends StatefulWidget {
  ClothesImagesInput({super.key});

  @override
  State<ClothesImagesInput> createState() => _ClothesImagesInputState();
}

class _ClothesImagesInputState extends State<ClothesImagesInput> {
  final ImagePicker _picker = ImagePicker();
  final List<XFile?> _pickedImages = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      color: Colors.white70,
      height: 140,
      child: Column(
        children: [
          SizedBox(height: 15,),
          Text("사진 등록",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),),
          SizedBox(height: 5,),
          ElevatedButton(onPressed: () { getMultiImage(); },
            child: const Icon(Icons.add_a_photo),
          ),
          Expanded(
          child: _pickedImages.isNotEmpty
          ? GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          ),
          children: _pickedImages
              .where((element) => element != null)
              .map((e) => _gridPhotoItem(e!))
              .toList(),
          )
              : const SizedBox(),
          )
        ],
      ),

    );


  }
  void getMultiImage() async {
    final List<XFile>? images = await _picker.pickMultiImage();

    if (images != null) {
      setState(() {
        _pickedImages.addAll(images);
      });
    }
  }

  Widget _gridPhotoItem(XFile e) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              File(e.path),
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 5,
            right: 5,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  _pickedImages.remove(e);
                });
              },
              child: const Icon(
                Icons.cancel_rounded,
                color: Colors.black87,
              ),
            ),
          )
        ],
      ),
    );
  }
}



//코멘트 작성 박스
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
              fontSize: 22,
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
