// To parse this JSON data, do
//
//     final deleteSingerResModel = deleteSingerResModelFromJson(jsonString);

import 'dart:convert';

DeleteSingerResModel deleteSingerResModelFromJson(String str) => DeleteSingerResModel.fromJson(json.decode(str));

String deleteSingerResModelToJson(DeleteSingerResModel data) => json.encode(data.toJson());

class DeleteSingerResModel {
    String message;
    bool status;

    DeleteSingerResModel({
        required this.message,
        required this.status,
    });

    factory DeleteSingerResModel.fromJson(Map<String, dynamic> json) => DeleteSingerResModel(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
