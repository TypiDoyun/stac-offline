import "merchant.dart";

class Clothes {
  String name, comment;
  List<String> size;
  List<String> images;
  int discountRate, price;
  Merchant owner;

  Clothes({
    required this.name,
    required this.images,
    required this.size,
    required this.comment,
    required this.price,
    required this.discountRate,
    required this.owner,
  });

  factory Clothes.fromJson(Map<String, dynamic> json) {
    Clothes clothes = Clothes(
      name: json["name"],
      images: List<String>.from(json["images"]),
      size: List<String>.from(json["size"]),
      comment: json["comment"],
      price: json["price"],
      discountRate: json["discountRate"],
      owner: Merchant.fromJson(json["owner"]),
    );
    return clothes;
  }
}
