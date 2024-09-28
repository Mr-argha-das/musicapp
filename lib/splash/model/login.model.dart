// To parse this JSON data, do
//
//     final loginModelBody = loginModelBodyFromJson(jsonString);

import 'dart:convert';

LoginModelBody loginModelBodyFromJson(String str) => LoginModelBody.fromJson(json.decode(str));

String loginModelBodyToJson(LoginModelBody data) => json.encode(data.toJson());

class LoginModelBody {
    String identifyer;
    String name;
    String mailorphone;

    LoginModelBody({
        required this.identifyer,
        required this.name,
        required this.mailorphone,
    });

    factory LoginModelBody.fromJson(Map<String, dynamic> json) => LoginModelBody(
        identifyer: json["identifyer"],
        name: json["name"],
        mailorphone: json["mailorphone"],
    );

    Map<String, dynamic> toJson() => {
        "identifyer": identifyer,
        "name": name,
        "mailorphone": mailorphone,
    };
}
