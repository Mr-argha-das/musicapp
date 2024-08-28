// To parse this JSON data, do
//
//     final songsBySingerModelbody = songsBySingerModelbodyFromJson(jsonString);

import 'dart:convert';

SongsBySingerModelbody songsBySingerModelbodyFromJson(String str) => SongsBySingerModelbody.fromJson(json.decode(str));

String songsBySingerModelbodyToJson(SongsBySingerModelbody data) => json.encode(data.toJson());

class SongsBySingerModelbody {
    String singername;

    SongsBySingerModelbody({
        required this.singername,
    });

    factory SongsBySingerModelbody.fromJson(Map<String, dynamic> json) => SongsBySingerModelbody(
        singername: json["singername"],
    );

    Map<String, dynamic> toJson() => {
        "singername": singername,
    };
}
