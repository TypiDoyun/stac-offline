class Shop {
  String name, shopNumber, logo, registrationNumber, address;
  List<double> location;

  Shop({
    required this.name,
    required this.shopNumber,
    required this.logo,
    required this.registrationNumber,
    required this.address,
    required this.location,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
        name: json["name"],
        shopNumber: json["shopNumber"],
        logo: json["logo"],
        registrationNumber: json["registrationNumber"],
        address: json["address"],
        location: List<double>.from(json["location"]),
      );
}
