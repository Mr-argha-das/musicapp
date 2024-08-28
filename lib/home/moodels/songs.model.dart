// To parse this JSON data, do
//
//     final songsBySingerModel = songsBySingerModelFromJson(jsonString);

import 'dart:convert';

SongsBySingerModel songsBySingerModelFromJson(String str) => SongsBySingerModel.fromJson(json.decode(str));

String songsBySingerModelToJson(SongsBySingerModel data) => json.encode(data.toJson());

class SongsBySingerModel {
    String message;
    List<Datum> data;
    bool status;

    SongsBySingerModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory SongsBySingerModel.fromJson(Map<String, dynamic> json) => SongsBySingerModel(
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
    String name;
    String image;
    String songsaudio;
    String singer;

    Datum({
        required this.id,
        required this.name,
        required this.image,
        required this.songsaudio,
        required this.singer,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: Id.fromJson(json["_id"]),
        name: json["Name"],
        image: json["image"],
        songsaudio: json["songsaudio"],
        singer: json["singer"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id.toJson(),
        "Name": name,
        "image": image,
        "songsaudio": songsaudio,
        "singer": singer,
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
