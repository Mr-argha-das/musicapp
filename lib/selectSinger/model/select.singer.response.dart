// To parse this JSON data, do
//
//     final selectSingerResModel = selectSingerResModelFromJson(jsonString);

import 'dart:convert';

SelectSingerResModel selectSingerResModelFromJson(String str) => SelectSingerResModel.fromJson(json.decode(str));

String selectSingerResModelToJson(SelectSingerResModel data) => json.encode(data.toJson());

class SelectSingerResModel {
    String message;
    Data data;
    bool status;

    SelectSingerResModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory SelectSingerResModel.fromJson(Map<String, dynamic> json) => SelectSingerResModel(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.toJson(),
        "status": status,
    };
}

class Data {
    Id id;
    String userid;
    String artistId;

    Data({
        required this.id,
        required this.userid,
        required this.artistId,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: Id.fromJson(json["_id"]),
        userid: json["userid"],
        artistId: json["artistID"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "userid": userid,
        "artistID": artistId,
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
