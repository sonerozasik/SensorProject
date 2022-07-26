// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

List<Post> postFromJson(String str) =>
    List<Post>.from(json.decode(str).map((x) => Post.fromJson(x)));

String postToJson(List<Post> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Post {
  Post({
    required this.id,
    required this.cihazId,
    required this.sicaklik,
    required this.pil,
    required this.date,
  });

  int id;
  int cihazId;
  int sicaklik;
  int pil;
  DateTime date;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        cihazId: json["cihazId"],
        sicaklik: json["sicaklik"],
        pil: json["pil"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "cihazId": cihazId,
        "sicaklik": sicaklik,
        "pil": pil,
        "date": date.toIso8601String(),
      };
}
