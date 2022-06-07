import 'package:flutter/material.dart';

class Weather {
  String? cityName;
  double? temp;
  String? description;
  Icon? icon;

  Weather({this.cityName, this.temp, this.description, this.icon});

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    description = json["weather"][0]["description"];
    icon = json["weather"][0]["icon"];
  }
}
