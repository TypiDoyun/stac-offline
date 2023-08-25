class User {
  String? username;
  String? id;
  String? password;
  String? phoneNumber;
  String? birthday;

  User({ required this.id, required this.username, required this.password, required this.phoneNumber, required this.birthday });

  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json["id"],
      username: json["username"],
      password: json["password"],
      phoneNumber: json["phoneNumber"],
      birthday: json["birthday"]
  );
}
// class User {
//   String username = "";
//   String id = "";
//   String password = "";
//   String phoneNumber = "";
//   String birthday = "";
//
//
//   User(this.username, this.id, this.password, this.phoneNumber,
//       this.birthday);
//
//   // factory User.fromJson(String json) => User(json["userToken"]);
//   //
//   // Map toJson() => {
//   //   "userName": "",
//   //   "userId": "",
//   //   "userPassword": "",
//   //   "userPhonenumber": "",
//   //   "userBirth": "",
//   // };
// }
