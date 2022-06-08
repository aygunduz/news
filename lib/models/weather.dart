class Weather {
  String? cityName;
  double? temp;
  String? description;

  Weather({
    this.cityName,
    this.temp,
    this.description,
  });

  Weather.fromJson(Map<String, dynamic> json) {
    cityName = json["name"];
    temp = json["main"]["temp"];
    description = json["weather"][0]["description"];
  }
}
