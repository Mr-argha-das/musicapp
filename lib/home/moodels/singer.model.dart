// To parse this JSON data, do
//
//     final singerModel = singerModelFromJson(jsonString);

import 'dart:convert';

SingerModel singerModelFromJson(String str) => SingerModel.fromJson(json.decode(str));

String singerModelToJson(SingerModel data) => json.encode(data.toJson());

class SingerModel {
    String message;
    List<String> data;
    bool status;

    SingerModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory SingerModel.fromJson(Map<String, dynamic> json) => SingerModel(
        message: json["message"],
        data: List<String>.from(json["data"].map((x) => x)),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x)),
        "status": status,
    };
}
