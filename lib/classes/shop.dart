import 'merchant.dart';

class Shop {
  String name, shopNumber, logo, registrationNumber;
  Merchant owner;

  Shop({
    required this.name,
    required this.shopNumber,
    required this.logo,
    required this.registrationNumber,
    required this.owner,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    name: json["name"],
    shopNumber: json["shopNumber"],
    logo: json["logo"],
    registrationNumber: json["registrationNumber"],
    owner: Merchant.fromJson(json["owner"]),
  );

}