import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:news/data/weather_services.dart';
import 'package:news/models/weather.dart';
import 'package:news/pages/content_news.dart';
import 'package:share_plus/share_plus.dart';

import '../data/news_services.dart';
import '../models/articles.dart';
import '../models/choose_city.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Articles> articles = [];
  int pageIndex = 0;
  Color? tileColor = Colors.red;
  String chooseCity = "";
  List<String> city = City().city;
  WeatherServices client = WeatherServices();
  Weather weather = Weather();
  //Save City for Reload;
  final dataCity = GetStorage();

  //Weather getData
  Future<void> getData() async {
    var _weather = (await client.getCurrentWeather(chooseCity))!;
    setState(() {
      weather = _weather;
    });
  }

  // News getData
  void generalNews() {
    NewsService.getGeneralNews(pageIndex).then((value) {
      setState(() {
        articles = value!;
      });
    });
  }

  // First start page
  @override
  void initState() {
    super.initState();
    generalNews();
    if (dataCity.read("city") != null) {
      chooseCity = dataCity.read("city");
      getData();
    }
    print("$chooseCity");
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            //Weather Menu
            Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.blueAccent, Colors.yellowAccent],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight),
                      borderRadius: BorderRadius.circular(20)),
                  child: buildWeather(),
                )),
            //Content Menu
            Expanded(
              flex: 27,
              child: ListView.builder(
                itemCount: articles.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                      color: Colors.black,
                      margin: EdgeInsets.only(left: 8, right: 8, bottom: 15),
                      child: Column(
                        children: [
                          ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                  articles[index].urlToImage.toString())),
                          methodListTile(index)
                        ],
                      ));
                },
              ),
            ),
            //Slider Menu
            Expanded(
              flex: 2,
              child: ListView(
                itemExtent: 100,
                scrollDirection: Axis.horizontal,
                children: [
                  //Anasayfa
                  buildListTile(0, "ANASAYFA"),

                  //Spor
                  buildListTile(1, "SPOR"),

                  // Finans
                  buildListTile(2, "FİNANS"),

                  //Bilim
                  buildListTile(3, "BİLİM"),

                  //Teknoloji
                  buildListTile(4, "TEKNOLOJİ"),

                  //Sağlık
                  buildListTile(5, "SAĞLIK"),

                  // Eğlence
                  buildListTile(6, "EĞLENCE"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row buildWeather() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        //CHOOSE CITY
        DropdownButton(
          dropdownColor: Colors.white,
          hint: Text(
            "Bir Şehir Seçiniz",
            style: TextStyle(color: Colors.white),
          ),
          value: chooseCity.isNotEmpty ? chooseCity : null,
          items: city.map((items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              chooseCity = newValue!;
              dataCity.write("city", chooseCity);
            });
            getData();
          },
        ),
        //DEGREE
        Text((weather.temp == null ? " " : "${weather.temp?.toInt()}°C "),
            style: TextStyle(color: Colors.black)),
        //DURUM
        Flexible(
          child: Text(
              (weather.description == null
                  ? " "
                  : "${weather.description?.toUpperCase()}"),
              style: TextStyle(color: Colors.black, fontSize: 12)),
        ),
      ],
    );
  }

  //Slider Menu
  ListTile buildListTile(int eleman, String string) {
    return ListTile(
      onTap: () {
        setState(() {
          pageIndex = eleman;
          generalNews();
        });
      },
      tileColor: (pageIndex == eleman ? Colors.redAccent : tileColor),
      title: Text(
        "$string",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 13, color: Colors.white),
      ),
    );
  }

  // List elemanlarını içerik sayfasına yönlendirme!
  GestureDetector methodListTile(int index) {
    // Basıldığında yapılan işlem
    return GestureDetector(
      onTap: () {
        Get.to(ContentNews(
          title: articles[index].title.toString(),
          url: articles[index].url.toString(),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: ListTile(
          title: Text(
            articles[index].title.toString(),
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 23),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 18),
                width: 85,
                height: 30,
                // SHARE BUTTON
                child: FloatingActionButton.extended(
                  backgroundColor: Colors.green,
                  onPressed: () {
                    Share.share(
                        "BU HABERİ GÖRMELİSİN ! \n\n\n${articles[index].url.toString()}");
                  },
                  label: Text(
                    "PAYLAŞ",
                    style: TextStyle(fontSize: 11),
                  ),
                  icon: Icon(
                    Icons.send,
                    size: 20,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  articles[index].author.toString(),
                  style: TextStyle(
                      color: Colors.red[900], fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
