
// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';
import 'package:ricky_morty/models/character_response.dart';
import 'package:ricky_morty/models/episode_response.dart';

abstract class Mappeable { }

class APIResponse<T extends Mappeable> {
    APIResponse({
        required this.info,
        required this.results,
    });

    Info? info;
    List<T> results;


    // Characters
    factory APIResponse.fromCharacterRawJson(String str) => APIResponse.fromCharacterJson(json.decode(str));

    factory APIResponse.fromCharacterJson(Map<String, dynamic> json) => APIResponse(
        info: Info.fromJson(json["info"]),
        results: List<T>.from(json["results"].map((x) => Character.fromJson(x))),
    );
  
    factory APIResponse.fromCharacterFilteredRawJson(String str) => APIResponse.fromCharacterFilteredJson(json.decode(str));

    factory APIResponse.fromCharacterFilteredJson(List<dynamic> list) => APIResponse(
        info: null,
        results: List<T>.from(list.map((x) => Character.fromJson(x))),
    );






    // Episodes
    factory APIResponse.fromEpisodeRawJson(String str) => APIResponse.fromEpisodeJson(json.decode(str));

    factory APIResponse.fromEpisodeJson(Map<String, dynamic> json) => APIResponse(
        info: Info.fromJson(json["info"]),
        results: List<T>.from(json["results"].map((x) => Episode.fromJson(x))),
    );

    factory APIResponse.fromEpisodeFilteredRawJson(String str) => APIResponse.fromEpisodeFilteredJson(json.decode(str));

    factory APIResponse.fromEpisodeFilteredJson(List<dynamic> list) => APIResponse(
        info: null,
        results: List<T>.from(list.map((x) => Episode.fromJson(x))),
    );
}

class Info {
    Info({
        required this.count,
        required this.pages,
        required this.next,
        this.prev,
    });

    int count;
    int pages;
    String next;
    dynamic prev;

    factory Info.fromRawJson(String str) => Info.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Info.fromJson(Map<String, dynamic> json) => Info(
        count: json["count"],
        pages: json["pages"],
        next: json["next"],
        prev: json["prev"],
    );

    Map<String, dynamic> toJson() => {
        "count": count,
        "pages": pages,
        "next": next,
        "prev": prev,
    };
}
