import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/weather_model.dart';

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
