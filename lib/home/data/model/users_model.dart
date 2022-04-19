import 'dart:convert';

List<User> usersFromJson(String str) =>
    List<User>.from(json.decode(str).map((x) => User.fromJson(x)));

String usersToJson(List<User> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class User {
  User({
    this.name,
    this.avatar,
    this.id,
  });

  String? name;
  String? avatar;
  String? id;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        avatar: json["avatar"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "avatar": avatar,
        "id": id,
      };
}
