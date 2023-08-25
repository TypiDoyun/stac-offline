import "merchant.dart";

class Clothes {
  String name, comment, price, id;
  List<String> images;
  int discountRate, size;
  Merchant owner;

  Clothes({
    required this.id,
    required this.name,
    required this.images,
    required this.size,
    required this.comment,
    required this.price,
    required this.discountRate,
    required this.owner,
  });

  factory Clothes.fromJson(Map<String, dynamic> json) => Clothes(
    id: json["id"],
    name: json["name"],
    images: json["images"],
    size: json["size"],
    comment: json["comment"],
    price: json["price"],
    discountRate: json["discountRate"],
    owner: Merchant.fromJson(json["owner"]),
  );
}
