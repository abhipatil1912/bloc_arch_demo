import 'dart:convert';

RegisterModel registerModelFromJson(String str) =>
    RegisterModel.fromJson(json.decode(str));

String registerModelToJson(RegisterModel data) => json.encode(data.toJson());

class RegisterModel {
  String? token;
  int? orgUserId;

  RegisterModel({
    this.token,
    this.orgUserId,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        token: json["token"],
        orgUserId: json["orgUser_id"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "orgUser_id": orgUserId,
      };
}
