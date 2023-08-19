import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../Widgets/user.dart';

class RememberToken {
  static Future saveRememberToken(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    await preferences.setString("currentUser", token);
  }
}