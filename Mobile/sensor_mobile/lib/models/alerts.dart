// To parse this JSON data, do
//
//     final alerts = alertsFromJson(jsonString);

import 'dart:convert';

List<Alerts> alertsFromJson(String str) =>
    List<Alerts>.from(json.decode(str).map((x) => Alerts.fromJson(x)));

String alertsToJson(List<Alerts> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Alerts {
  Alerts({
    required this.deviceId,
    required this.type,
    required this.message,
    required this.date,
  });

  int deviceId;
  String type;
  String message;
  DateTime date;

  factory Alerts.fromJson(Map<String, dynamic> json) => Alerts(
        deviceId: json["deviceId"],
        type: json["type"],
        message: json["message"],
        date: DateTime.parse(json["date"]),
      );

  Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "type": type,
        "message": message,
        "date": date.toIso8601String(),
      };
}
