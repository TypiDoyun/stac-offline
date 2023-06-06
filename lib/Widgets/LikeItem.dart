import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LikeItem extends StatelessWidget {
  late String closeName;
  late String meseges;


  @override
  Widget build(BuildContext context) {
    return const ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage('assets/images/Testlogo.png')
      ),
      title: Text('Sun'),
      subtitle: Text('93 million miles away'),
    );
  }

}