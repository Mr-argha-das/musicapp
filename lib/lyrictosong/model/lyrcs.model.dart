class LyrcsSOngResult {
    LyrcsSOngResult({
        required this.message,
        required this.data,
    });

    final String? message;
    final Data? data;

    factory LyrcsSOngResult.fromJson(Map<String, dynamic> json){ 
        return LyrcsSOngResult(
            message: json["message"],
            data: json["data"] == null ? null : Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data?.toJson(),
    };

}

class Data {
    Data({
        required this.id,
        required this.name,
        required this.image,
        required this.songsaudio,
        required this.singer,
        required this.lyrics,
    });

    final Id? id;
    final String? name;
    final String? image;
    final String? songsaudio;
    final String? singer;
    final String? lyrics;

    factory Data.fromJson(Map<String, dynamic> json){ 
        return Data(
            id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
            name: json["Name"],
            image: json["image"],
            songsaudio: json["songsaudio"],
            singer: json["singer"],
            lyrics: json["lyrics"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id?.toJson(),
        "Name": name,
        "image": image,
        "songsaudio": songsaudio,
        "singer": singer,
        "lyrics": lyrics,
    };

}

class Id {
    Id({
        required this.oid,
    });

    final String? oid;

    factory Id.fromJson(Map<String, dynamic> json){ 
        return Id(
            oid: json["\u0024oid"],
        );
    }

    Map<String, dynamic> toJson() => {
        "\u0024oid": oid,
    };

}
