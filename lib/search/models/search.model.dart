// To parse this JSON data, do
//
//     final searchResultModel = searchResultModelFromJson(jsonString);

import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
    String message;
    List<Datum> data;
    bool status;

    SearchResultModel({
        required this.message,
        required this.data,
        required this.status,
    });

    factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
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
