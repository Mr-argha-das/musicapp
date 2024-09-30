// To parse this JSON data, do
//
//     final selectSingerModel = selectSingerModelFromJson(jsonString);

import 'dart:convert';

SelectSingerModel selectSingerModelFromJson(String str) => SelectSingerModel.fromJson(json.decode(str));

String selectSingerModelToJson(SelectSingerModel data) => json.encode(data.toJson());

class SelectSingerModel {
    String userid;
    String artistId;

    SelectSingerModel({
        required this.userid,
        required this.artistId,
    });

    factory SelectSingerModel.fromJson(Map<String, dynamic> json) => SelectSingerModel(
        userid: json["userid"],
        artistId: json["artistID"],
    );

    Map<String, dynamic> toJson() => {
        "userid": userid,
        "artistID": artistId,
    };
}
