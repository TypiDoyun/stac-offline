class Clothes {
  String clothesname, images, size, tags, comment, price, id;
  bool saleBool;
  int saleValue;

  Clothes(this.id, this.clothesname, this.images, this.size, this.tags, this.comment,
      this.price, this.saleBool, this.saleValue,);

  // static Clothes fromJson(decode) {
  // }


  // factory Clothes.fromJson(Map<String, dynamic> json) =>
  //     Clothes(
  //       clothesname: json["clothesname"],
  //       images: json["images"],
  //       size: json["size"],
  //       tags: json["tags"],
  //       comment: json["comment"],
  //       price: json["price"],
  //       saleBool: json["saleBool"],
  //       saleValue: json["saleValue"],
  //     );
}