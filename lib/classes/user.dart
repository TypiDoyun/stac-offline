class User {
  String id, username, phoneNumber, birthday;

  User({
    required this.id,
    required this.username,
    required this.phoneNumber,
    required this.birthday,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    username: json["username"],
    phoneNumber: json["phoneNumber"],
    birthday: json["birthday"],
  );
}
