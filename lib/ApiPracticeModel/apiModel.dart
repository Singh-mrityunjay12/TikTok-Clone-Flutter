// To parse this JSON data, do
//
//     final name = nameFromJson(jsonString);

import 'dart:convert';

List<Name> nameFromJson(String str) =>
    List<Name>.from(json.decode(str).map((x) => Name.fromJson(x)));

String nameToJson(List<Name> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Name {
  int userId;
  int id;
  String title;
  String body;

  Name({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        body: json["body"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "body": body,
      };
}
