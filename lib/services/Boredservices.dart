// To parse this JSON data, do
//
//     final boredActivity = boredActivityFromJson(jsonString);

import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

BoredActivity boredActivityFromJson(String str) =>
    BoredActivity.fromJson(json.decode(str));

String boredActivityToJson(BoredActivity data) => json.encode(data.toJson());

class BoredActivity {
  BoredActivity({
    required this.activity,
    required this.type,
    required this.participants,
    required this.price,
    required this.link,
    required this.key,
    required this.accessibility,
  });

  String activity;
  String type;
  int participants;
  double price;
  String link;
  String key;
  double accessibility;

  factory BoredActivity.fromJson(Map<String, dynamic> json) => BoredActivity(
        activity: json["activity"],
        type: json["type"],
        participants: json["participants"],
        price: json["price"].toDouble(),
        link: json["link"],
        key: json["key"],
        accessibility: json["accessibility"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "activity": activity,
        "type": type,
        "participants": participants,
        "price": price,
        "link": link,
        "key": key,
        "accessibility": accessibility,
      };
}

class BoredService {
  Future<Weather> getBoredActivity(String placename) async {
    var url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=${placename}&APPID=915d4676ee5c3ca47c33631069748c75');
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    final activity = weatherFromJson(response.body);
    return activity;
  }
}
