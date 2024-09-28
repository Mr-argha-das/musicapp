// To parse this JSON data, do
//
//     final loginModelResponse = loginModelResponseFromJson(jsonString);

import 'dart:convert';

LoginModelResponse loginModelResponseFromJson(String str) => LoginModelResponse.fromJson(json.decode(str));

String loginModelResponseToJson(LoginModelResponse data) => json.encode(data.toJson());

class LoginModelResponse {
    String message;
    List<Datum> data;
    bool status;

    LoginModelResponse({
        required this.message,
        required this.data,
        required this.status,
    });

    factory LoginModelResponse.fromJson(Map<String, dynamic> json) => LoginModelResponse(
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Id id;
    String identifyer;
    String name;
    String mailorphone;

    Datum({
        required this.id,
        required this.identifyer,
        required this.name,
        required this.mailorphone,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: Id.fromJson(json["_id"]),
        identifyer: json["identifyer"],
        name: json["name"],
        mailorphone: json["mailorphone"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "identifyer": identifyer,
        "name": name,
        "mailorphone": mailorphone,
    };
}

class Id {
    String oid;

    Id({
        required this.oid,
    });

    factory Id.fromJson(Map<String, dynamic> json) => Id(
        oid: json["\u0024oid"],
    );

    Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
    };
}
