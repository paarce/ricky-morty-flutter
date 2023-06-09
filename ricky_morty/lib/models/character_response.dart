
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'package:ricky_morty/helpers/models_helper.dart';
import 'package:ricky_morty/models/api_response.dart';

typedef APIResponseCharacters = APIResponse<Character>;

class Character extends Mappeable {
    Character({
        required this.id,
        required this.name,
        required this.status,
        required this.species,
        required this.type,
        required this.gender,
        required this.origin,
        required this.location,
        required this.image,
        required this.episode,
        required this.url,
        required this.created,
    });

    int id;
    String name;
    Status status;
    Species species;
    String type;
    Gender gender;
    LocationSummary origin;
    LocationSummary location;
    String image;
    List<String> episode;
    String url;
    DateTime created;

    factory Character.fromRawJson(String str) => Character.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Character.fromJson(Map<String, dynamic> json) => Character(
        id: json["id"],
        name: json["name"],
        status: statusValues.map[json["status"]]!,
        species: speciesValues.map[json["species"]]!,
        type: json["type"],
        gender: genderValues.map[json["gender"]]!,
        origin: LocationSummary.fromJson(json["origin"]),
        location: LocationSummary.fromJson(json["location"]),
        image: json["image"],
        episode: List<String>.from(json["episode"].map((x) => x)),
        url: json["url"],
        created: DateTime.parse(json["created"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": statusValues.reverse[status],
        "species": speciesValues.reverse[species],
        "type": type,
        "gender": genderValues.reverse[gender],
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
        "episode": List<dynamic>.from(episode.map((x) => x)),
        "url": url,
        "created": created.toIso8601String(),
    };

    
}

enum Gender { MALE, FEMALE, UNKNOWN, GENDERLESS }

final genderValues = EnumValues({
    "Female": Gender.FEMALE,
    "Male": Gender.MALE,
    "Genderless": Gender.GENDERLESS ,
    "unknown": Gender.UNKNOWN
});

class LocationSummary {
    LocationSummary({
        required this.name,
        required this.url,
    });

    String name;
    String url;

    factory LocationSummary.fromRawJson(String str) => LocationSummary.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory LocationSummary.fromJson(Map<String, dynamic> json) => LocationSummary(
        name: json["name"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
    };

    String id() => ModelHelper.getIdFrom(url);
}

enum Species { HUMAN, ALIEN, HUMANOID, POOPYBUTTHOLE,
MYTHOLOGICALCREATURE, CRONENBERG, DISEASE, ROBOT,
ANIMAL, UNKNOWN }

final speciesValues = EnumValues({
    "Alien": Species.ALIEN,
    "Human": Species.HUMAN,
    "Humanoid": Species.HUMANOID,
    "Poopybutthole": Species.POOPYBUTTHOLE,
    "Mythological Creature": Species.MYTHOLOGICALCREATURE,
    "Cronenberg": Species.CRONENBERG,
    "Disease": Species.DISEASE,
    "Robot": Species.ROBOT,
    "Animal": Species.ANIMAL,
    "unknown": Species.UNKNOWN,
});

enum Status { ALIVE, UNKNOWN, DEAD }

final statusValues = EnumValues({
    "Alive": Status.ALIVE,
    "Dead": Status.DEAD,
    "unknown": Status.UNKNOWN
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}