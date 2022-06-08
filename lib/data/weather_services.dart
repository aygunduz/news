import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news/apikeys/apikeys.dart';

import '../models/weather.dart';

class WeatherServices {
  Future<Weather?> getCurrentWeather(String city) async {
    var url = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$weatherApiKey&units=metric&lang=tr");
    var response = await http.get(url);
    if (response.body.isNotEmpty) {
      final responseJson = json.decode(response.body);
      Weather weather = Weather.fromJson(responseJson);
      print(response);
      return weather;
    }
  }
}
