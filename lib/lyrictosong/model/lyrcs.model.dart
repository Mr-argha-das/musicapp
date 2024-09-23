// To parse this JSON data, do
//
//     final lyrcsSOngResult = lyrcsSOngResultFromJson(jsonString);

import 'dart:convert';

LyrcsSOngResult lyrcsSOngResultFromJson(String str) => LyrcsSOngResult.fromJson(json.decode(str));

String lyrcsSOngResultToJson(LyrcsSOngResult data) => json.encode(data.toJson());

class LyrcsSOngResult {
    String message;
    Data? data;
    bool staus;

    LyrcsSOngResult({
        required this.message,
        required this.data,
        required this.staus,
    });

    factory LyrcsSOngResult.fromJson(Map<String, dynamic> json) => LyrcsSOngResult(
        message: json["message"],
        data: Data.fromJson(json["data"]),
        staus: json["staus"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
        "staus": staus,
    };
}

class Data {
    Songs songs;

    Data({
        required this.songs,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        songs: Songs.fromJson(json["songs"]),
    );

    Map<String, dynamic> toJson() => {
        "songs": songs.toJson(),
    };
}

class Songs {
    String the0;

    Songs({
        required this.the0,
    });

    factory Songs.fromJson(Map<String, dynamic> json) => Songs(
        the0: json["0"],
    );

    Map<String, dynamic> toJson() => {
        "0": the0,
    };
}
