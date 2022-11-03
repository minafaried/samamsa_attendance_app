class User {
  String id;
  String userName;
  String email;
  String password;
  bool isAdmin;

  User(
      {required this.id,
      required this.userName,
      required this.email,
      required this.password,
      required this.isAdmin});

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? "",
        userName: json["userName"] ?? '',
        email: json["email"] ?? '',
        password: json["password"] ?? '',
        isAdmin: json["isAdmin"] ?? 0,
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userName": userName,
        "email": email,
        "password": password,
        "isAdmin": isAdmin,
      };
}
