import "shop.dart";
import "clothes.dart";
import "user.dart";

class Merchant extends User {
  String residentNumber;
  List<double> location;
  Shop? shop;


  Merchant({
    required id,
    required username,
    required phoneNumber,
    required birthday,
    required this.residentNumber,
    required this.location,
    required this.shop,
  }) : super(id: id, username: username, phoneNumber: phoneNumber, birthday: birthday);

  @override
  factory Merchant.fromJson(Map<String, dynamic> json) => Merchant(
    id: json["id"],
    username: json["username"],
    phoneNumber: json["phoneNumber"],
    birthday: json["birthday"],
    residentNumber: json["residentNumber"],
    location: List<double>.from(json["location"].map((item) => item.toDouble())),
    shop: json["shop"] == null ? null : Shop.fromJson(json["shop"]),
  );
}
