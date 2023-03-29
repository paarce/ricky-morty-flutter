import 'dart:convert';

class Location {
    Location({
        required this.id,
        required this.name,
        required this.type,
        required this.dimension,
        required this.residents,
        required this.url,
        required this.created,
    });

    int id;
    String name;
    String type;
    String dimension;
    List<String> residents;
    String url;
    DateTime created;
    
    factory Location.fromRawJson(String str) => Location.fromJson(json.decode(str));

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
        type: json["type"],
        dimension: json["dimension"],
        residents: List<String>.from(json["residents"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "dimension": dimension,
        "residents": List<dynamic>.from(residents.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };
}
