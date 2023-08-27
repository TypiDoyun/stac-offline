import 'merchant.dart';

class Shop {
  String name, shopNumber, logo, registrationNumber; 

  Shop({
    required this.name,
    required this.shopNumber,
    required this.logo,
    required this.registrationNumber
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    name: json["name"],
    shopNumber: json["shopNumber"],
    logo: json["logo"],
    registrationNumber: json["registrationNumber"]
  );

}