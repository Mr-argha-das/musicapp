class Artist {
    Artist({
        required this.message,
        required this.data,
        required this.status,
    });

    final String? message;
    final List<Datum> data;
    final bool? status;

    factory Artist.fromJson(Map<String, dynamic> json){ 
        return Artist(
            message: json["message"],
            data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
            status: json["status"],
        );
    }

    Map<String, dynamic> toJson() => {
        "message": message,
        "data": data.map((x) => x?.toJson()).toList(),
        "status": status,
    };

}

class Datum {
    Datum({
        required this.id,
        required this.name,
        required this.image,
    });

    final Id? id;
    final String? name;
    final String? image;

    factory Datum.fromJson(Map<String, dynamic> json){ 
        return Datum(
            id: json["_id"] == null ? null : Id.fromJson(json["_id"]),
            name: json["name"],
            image: json["image"],
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id?.toJson(),
        "name": name,
        "image": image,
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
