import 'package:shared_preferences/shared_preferences.dart';

import '../../servercontroller.dart';

isRefreshTokenValid() async {
  SharedPreferences prefer = await SharedPreferences.getInstance();
  String? refreshToken = prefer.getString("refreshToken");

  if (refreshToken == null) return;
  dynamic accessPayload = parseJwtPayLoad(refreshToken);

  int now = DateTime.now().millisecondsSinceEpoch;

  int expirationTime = accessPayload["exp"] * 1000;
  if (expirationTime - 5000 > now) return true;

  return false;
}